package com.poojithairosha.shofy.service;

import com.poojithairosha.shofy.dto.BuyNowReqDTO;
import com.poojithairosha.shofy.dto.CheckoutReqDTO;
import com.poojithairosha.shofy.dto.HashDTO;
import com.poojithairosha.shofy.exception.CustomException;
import com.poojithairosha.shofy.mail.OrderConfirmationMail;
import com.poojithairosha.shofy.model.cart.Cart;
import com.poojithairosha.shofy.model.cart.CartItem;
import com.poojithairosha.shofy.model.order.*;
import com.poojithairosha.shofy.model.product.Product;
import com.poojithairosha.shofy.model.product.ProductColors;
import com.poojithairosha.shofy.model.user.User;
import com.poojithairosha.shofy.provider.MailServiceProvider;
import com.poojithairosha.shofy.util.HibernateUtil;
import jakarta.inject.Inject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.Response;
import org.hibernate.Session;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

public class CheckoutService {

    @Inject
    private CartService cartService;

    @Inject
    private ProductService productService;

    @Context
    private HttpServletRequest request;


    public HashMap<String, Object> getCheckout() {
        User user = (User) request.getSession().getAttribute("user");
        Cart cart = cartService.getCart();

        if (cart.getCartItems().size() <= 0) {
            throw new CustomException(Response.Status.BAD_REQUEST, "Cart is empty");
        }

        List<DeliveryFee> deliveryFees = getDeliveryFees();

        HashMap<String, Object> data = new HashMap<>();
        data.put("user", user);
        data.put("cart", cart);
        data.put("deliveryFees", deliveryFees);
        data.put("buyNow", false);

        return data;
    }

    public List<DeliveryFee> getDeliveryFees() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            session.beginTransaction();
            List<DeliveryFee> fromDeliveryFee = session.createQuery("from DeliveryFee", DeliveryFee.class).list();
            session.getTransaction().commit();
            return fromDeliveryFee;
        } catch (CustomException e) {
            throw new CustomException(e.getStatus(), e.getMessage());
        } catch (Exception e) {
            throw new CustomException(Response.Status.INTERNAL_SERVER_ERROR, e.getMessage());
        }

    }

    public HashDTO getHash(double amount) {
        String merchantID = "1223041";
        String merchantSecret = "MzU2NTA5OTMxMzI4NjQzMzE5MzMxMTM5NjAwMDMzNTc3MTE1MTk0";
        String orderID = UUID.randomUUID().toString();
        String currency = "USD";
        DecimalFormat df = new DecimalFormat("0.00");
        String amountFormatted = df.format(amount);
        String hash = getMd5(merchantID + orderID + amountFormatted + currency + getMd5(merchantSecret));
        return new HashDTO(merchantID, orderID, amountFormatted, currency, hash);
    }

    public static String getMd5(String input) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] messageDigest = md.digest(input.getBytes());
            BigInteger no = new BigInteger(1, messageDigest);
            String hashtext = no.toString(16);
            while (hashtext.length() < 32) {
                hashtext = "0" + hashtext;
            }
            return hashtext.toUpperCase();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }

    public String checkout(CheckoutReqDTO dto) {

        User user = (User) request.getSession().getAttribute("user");

        try (Session session = HibernateUtil.getSessionFactory().openSession()) {

            session.beginTransaction();

            DeliveryFee deliveryFee = session.find(DeliveryFee.class, dto.getDeliveryFee());

            Order order = new Order(user, dto.getTotal(), OrderStatus.CONFIRMED, deliveryFee, new OrderAddress(dto.getFirstName(), dto.getLastName(), dto.getEmail(), dto.getMobile(), dto.getAddressLine1(), dto.getAddressLine2(), dto.getCity(), dto.getZipCode()), dto.getOrderId());

            Cart cart = session.createQuery("from Cart c where c.user.id = :userId", Cart.class).setParameter("userId", user.getId()).uniqueResult();

            List<OrderItem> orderItemList = new ArrayList<>();

            cart.getCartItems().forEach(cartItem -> {
                OrderItem orderItem = new OrderItem(cartItem.getQuantity(), cartItem.getProduct().getPrice(), cartItem.getProduct(), order);
                int pqty = cartItem.getProduct().getQuantity();
                cartItem.getProduct().setQuantity(pqty - cartItem.getQuantity());
                orderItemList.add(orderItem);
            });

            order.setOrderItems(orderItemList);

            cart.getCartItems().clear();
            cart.setTotal(0.0);
            session.merge(cart);

            session.persist(order);

            session.refresh(order);

            session.getTransaction().commit();

            MailServiceProvider.getInstance().sendMail(new OrderConfirmationMail(user.getEmail(), order));

            return "success";
        } catch (CustomException e) {
            throw e;
        } catch (Exception e) {
            throw new CustomException(Response.Status.INTERNAL_SERVER_ERROR, e.getMessage());
        }

    }

    public String buyNow(BuyNowReqDTO dto) {
        User user = (User) request.getSession().getAttribute("user");

        try (Session session = HibernateUtil.getSessionFactory().openSession()) {

            session.beginTransaction();

            DeliveryFee deliveryFee = session.find(DeliveryFee.class, dto.getDeliveryFee());

            Order order = new Order(user, dto.getTotal(), OrderStatus.CONFIRMED, deliveryFee, new OrderAddress(dto.getFirstName(), dto.getLastName(), dto.getEmail(), dto.getMobile(), dto.getAddressLine1(), dto.getAddressLine2(), dto.getCity(), dto.getZipCode()), dto.getOrderId());

            List<OrderItem> orderItemList = new ArrayList<>();
            Product product = session.createQuery("from Product p where p.id=:pid", Product.class).setParameter("pid", dto.getProductId()).uniqueResult();
            ProductColors color = session.createQuery("from ProductColors c where c.id=:id", ProductColors.class).setParameter("id", dto.getColorId()).uniqueResult();

            OrderItem orderItem = new OrderItem(dto.getQty(), product.getPrice(), product, order);
            orderItemList.add(orderItem);
            order.setOrderItems(orderItemList);

            product.setQuantity(product.getQuantity() - dto.getQty());

            session.persist(order);
            session.merge(product);

            session.refresh(order);
            session.getTransaction().commit();

            MailServiceProvider.getInstance().sendMail(new OrderConfirmationMail(user.getEmail(), order));
            return "success";
        } catch (CustomException e) {
            throw e;
        } catch (Exception e) {
            throw new CustomException(Response.Status.INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }

    public HashMap<String, Object> getBuyNowDetails(Long id, int qty, Long color) {

        try (Session session = HibernateUtil.getSessionFactory().openSession()) {

            Product productById = productService.getActiveProductById(id);
            User user = (User) request.getSession().getAttribute("user");

            ProductColors productColors = session.createQuery("from ProductColors c where c.id=:id", ProductColors.class).setParameter("id", color).uniqueResult();

            Cart cart = new Cart();
            cart.setTotal(productById.getPrice() * qty);
            cart.setCartItems(List.of(new CartItem(productById, qty, productColors, cart)));
            cart.setUser(user);

            HashMap<String, Object> data = new HashMap<>();
            data.put("user", user);
            data.put("cart", cart);
            data.put("deliveryFees", getDeliveryFees());
            data.put("buyNow", true);

            return data;
        } catch (Exception e) {
            throw new CustomException(Response.Status.INTERNAL_SERVER_ERROR, e.getMessage());
        }


    }
}
