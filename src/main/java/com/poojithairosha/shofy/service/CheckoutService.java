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
                orderItemList.add(orderItem);
            });

            order.setOrderItems(orderItemList);

            cart.getCartItems().clear();
            cart.setTotal(0.0);
            session.merge(cart);

            session.persist(order);

            session.refresh(order);

            session.getTransaction().commit();

//            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//            String emailContent = "<!DOCTYPE html>\n" +
//                    "<html>\n" +
//                    "<head>\n" +
//                    "  <link\n" +
//                    "          href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css\"\n" +
//                    "          rel=\"stylesheet\"\n" +
//                    "          integrity=\"sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN\"\n" +
//                    "          crossorigin=\"anonymous\"\n" +
//                    "  />\n" +
//                    "  <style>\n" +
//                    "    .tp-order-details {\n" +
//                    "      padding: 70px 100px 55px;\n" +
//                    "    }\n" +
//                    "    @media only screen and (min-width: 1200px) and (max-width: 1399px) {\n" +
//                    "      .tp-order-details {\n" +
//                    "        padding: 70px 70px 55px;\n" +
//                    "      }\n" +
//                    "    }\n" +
//                    "    @media only screen and (min-width: 992px) and (max-width: 1199px) {\n" +
//                    "      .tp-order-details {\n" +
//                    "        padding: 70px 30px 55px;\n" +
//                    "      }\n" +
//                    "    }\n" +
//                    "    @media only screen and (min-width: 576px) and (max-width: 767px) {\n" +
//                    "      .tp-order-details {\n" +
//                    "        padding: 70px 50px 55px;\n" +
//                    "      }\n" +
//                    "    }\n" +
//                    "    @media (max-width: 575px) {\n" +
//                    "      .tp-order-details {\n" +
//                    "        padding: 40px 30px 45px;\n" +
//                    "      }\n" +
//                    "    }\n" +
//                    "    .tp-order-details-icon {\n" +
//                    "      margin-bottom: 22px;\n" +
//                    "    }\n" +
//                    "    .tp-order-details-icon span {\n" +
//                    "      display: inline-block;\n" +
//                    "      width: 120px;\n" +
//                    "      height: 120px;\n" +
//                    "      line-height: 118px;\n" +
//                    "      text-align: center;\n" +
//                    "      font-size: 55px;\n" +
//                    "      color: #ffffff;\n" +
//                    "      border: 1px solid rgba(255, 255, 255, 0.2);\n" +
//                    "      border-radius: 50%;\n" +
//                    "    }\n" +
//                    "    .tp-order-details-title {\n" +
//                    "      font-size: 30px;\n" +
//                    "      font-weight: 600;\n" +
//                    "      color: #ffffff;\n" +
//                    "      margin-bottom: 7px;\n" +
//                    "    }\n" +
//                    "    .tp-order-details-content p {\n" +
//                    "      font-size: 16px;\n" +
//                    "      color: #ffffff;\n" +
//                    "      line-height: 1.38;\n" +
//                    "    }\n" +
//                    "    .tp-order-details-item {\n" +
//                    "      margin-bottom: 38px;\n" +
//                    "    }\n" +
//                    "    .tp-order-details-item-wrapper\n" +
//                    "    .row\n" +
//                    "    [class*=\"col-\"]:nth-child(2n)\n" +
//                    "    .tp-order-details-item {\n" +
//                    "      padding-left: 40px;\n" +
//                    "    }\n" +
//                    "    @media (max-width: 575px) {\n" +
//                    "      .tp-order-details-item-wrapper\n" +
//                    "      .row\n" +
//                    "      [class*=\"col-\"]:nth-child(2n)\n" +
//                    "      .tp-order-details-item {\n" +
//                    "        padding-left: 0;\n" +
//                    "      }\n" +
//                    "    }\n" +
//                    "    .tp-order-details-item h4 {\n" +
//                    "      font-size: 18px;\n" +
//                    "      color: #ffffff;\n" +
//                    "      margin-bottom: 0;\n" +
//                    "      font-weight: 400;\n" +
//                    "    }\n" +
//                    "    .tp-order-details-item p {\n" +
//                    "      font-weight: 700;\n" +
//                    "      font-size: 18px;\n" +
//                    "      color: #ffffff;\n" +
//                    "      margin-bottom: 0;\n" +
//                    "    }\n" +
//                    "    .tp-order-info-wrapper {\n" +
//                    "      padding: 42px 50px;\n" +
//                    "    }\n" +
//                    "    @media only screen and (min-width: 992px) and (max-width: 1199px) {\n" +
//                    "      .tp-order-info-wrapper {\n" +
//                    "        padding: 42px 40px;\n" +
//                    "      }\n" +
//                    "    }\n" +
//                    "    @media (max-width: 575px) {\n" +
//                    "      .tp-order-info-wrapper {\n" +
//                    "        padding: 42px 30px;\n" +
//                    "      }\n" +
//                    "    }\n" +
//                    "    .tp-order-info-title {\n" +
//                    "      font-size: 26px;\n" +
//                    "      font-weight: 600;\n" +
//                    "      margin-bottom: 40px;\n" +
//                    "    }\n" +
//                    "    .tp-order-info-list ul li {\n" +
//                    "      list-style: none;\n" +
//                    "      padding: 15px 0;\n" +
//                    "      display: -webkit-box;\n" +
//                    "      display: -moz-box;\n" +
//                    "      display: -ms-flexbox;\n" +
//                    "      display: -webkit-flex;\n" +
//                    "      display: flex;\n" +
//                    "      align-items: center;\n" +
//                    "      justify-content: space-between;\n" +
//                    "    }\n" +
//                    "    .tp-order-info-list ul li:not(:last-child) {\n" +
//                    "      border-bottom: 1px solid #e0e2e3;\n" +
//                    "    }\n" +
//                    "    .tp-order-info-list ul li span {\n" +
//                    "      font-size: 15px;\n" +
//                    "      color: #010f1c;\n" +
//                    "    }\n" +
//                    "    .tp-order-info-list ul li.tp-order-info-list-header {\n" +
//                    "      padding-top: 0;\n" +
//                    "      padding-bottom: 12px;\n" +
//                    "    }\n" +
//                    "    .tp-order-info-list ul li.tp-order-info-list-header h4 {\n" +
//                    "      font-size: 16px;\n" +
//                    "      font-weight: 500;\n" +
//                    "      margin-bottom: 0;\n" +
//                    "    }\n" +
//                    "    .tp-order-info-list ul li.tp-order-info-list-desc p {\n" +
//                    "      font-size: 15px;\n" +
//                    "      margin-bottom: 0;\n" +
//                    "    }\n" +
//                    "    .tp-order-info-list ul li.tp-order-info-list-desc p span {\n" +
//                    "      font-size: 15px;\n" +
//                    "      font-weight: 500;\n" +
//                    "    }\n" +
//                    "    .tp-order-info-list ul li.tp-order-info-list-subtotal span:last-child {\n" +
//                    "      color: #0989ff;\n" +
//                    "    }\n" +
//                    "    .tp-order-info-list ul li.tp-order-info-list-shipping span input {\n" +
//                    "      display: none;\n" +
//                    "    }\n" +
//                    "    .tp-order-info-list\n" +
//                    "    ul\n" +
//                    "    li.tp-order-info-list-shipping\n" +
//                    "    span\n" +
//                    "    input:checked\n" +
//                    "    ~ label::after {\n" +
//                    "      border-color: #0989ff;\n" +
//                    "    }\n" +
//                    "    .tp-order-info-list\n" +
//                    "    ul\n" +
//                    "    li.tp-order-info-list-shipping\n" +
//                    "    span\n" +
//                    "    input:checked\n" +
//                    "    ~ label::before {\n" +
//                    "      opacity: 1;\n" +
//                    "      visibility: visible;\n" +
//                    "    }\n" +
//                    "    .tp-order-info-list ul li.tp-order-info-list-shipping span label {\n" +
//                    "      font-size: 14px;\n" +
//                    "      position: relative;\n" +
//                    "      padding-right: 27px;\n" +
//                    "    }\n" +
//                    "    .tp-order-info-list ul li.tp-order-info-list-shipping span label span {\n" +
//                    "      color: #0989ff;\n" +
//                    "    }\n" +
//                    "    .tp-order-info-list ul li.tp-order-info-list-shipping span label:hover {\n" +
//                    "      cursor: pointer;\n" +
//                    "    }\n" +
//                    "    .tp-order-info-list ul li.tp-order-info-list-shipping span label::after {\n" +
//                    "      position: absolute;\n" +
//                    "      content: \"\";\n" +
//                    "      right: 0;\n" +
//                    "      top: 5px;\n" +
//                    "      width: 16px;\n" +
//                    "      height: 16px;\n" +
//                    "      border-radius: 50%;\n" +
//                    "      border: 1px solid #bcbcbc;\n" +
//                    "      -webkit-transition: all 0.2s 0s ease-out;\n" +
//                    "      -moz-transition: all 0.2s 0s ease-out;\n" +
//                    "      -ms-transition: all 0.2s 0s ease-out;\n" +
//                    "      -o-transition: all 0.2s 0s ease-out;\n" +
//                    "      transition: all 0.2s 0s ease-out;\n" +
//                    "    }\n" +
//                    "    .tp-order-info-list ul li.tp-order-info-list-shipping span label::before {\n" +
//                    "      position: absolute;\n" +
//                    "      content: \"\";\n" +
//                    "      right: 4px;\n" +
//                    "      top: 9px;\n" +
//                    "      width: 8px;\n" +
//                    "      height: 8px;\n" +
//                    "      border-radius: 50%;\n" +
//                    "      background-color: #0989ff;\n" +
//                    "      visibility: hidden;\n" +
//                    "      opacity: 0;\n" +
//                    "      -webkit-transition: all 0.2s 0s ease-out;\n" +
//                    "      -moz-transition: all 0.2s 0s ease-out;\n" +
//                    "      -ms-transition: all 0.2s 0s ease-out;\n" +
//                    "      -o-transition: all 0.2s 0s ease-out;\n" +
//                    "      transition: all 0.2s 0s ease-out;\n" +
//                    "    }\n" +
//                    "    .tp-order-info-list ul li.tp-order-info-list-total {\n" +
//                    "      padding: 14px 0;\n" +
//                    "    }\n" +
//                    "    .tp-order-info-list ul li.tp-order-info-list-total span {\n" +
//                    "      font-size: 16px;\n" +
//                    "      font-weight: 500;\n" +
//                    "    }\n" +
//                    "    .tp-order-inner {\n" +
//                    "      background-color: #ffffff;\n" +
//                    "      box-shadow: 0px 30px 70px rgba(1, 15, 28, 0.1);\n" +
//                    "    }\n" +
//                    "  </style>\n" +
//                    "</head>\n" +
//                    "<body style=\"height: 100vh; display: flex; align-items: center; justify-content: center;\">\n" +
//                    "<section\n" +
//                    "        class=\"tp-order-area pb-160\">\n" +
//                    "  <div class=\"container\">\n" +
//                    "    <div class=\"tp-order-inner\">\n" +
//                    "      <div class=\"row gx-0\">\n" +
//                    "        <div class=\"col-lg-6\" style=\"background-color: #4f3d97\">\n" +
//                    "          <div class=\"tp-order-details\" data-bg-color=\"#4F3D97\">\n" +
//                    "            <div class=\"tp-order-details-top text-center mb-70\">\n" +
//                    "              <div\n" +
//                    "                      class=\"tp-order-details-icon d-flex justify-content-center\"\n" +
//                    "              >\n" +
//                    "                    <span\n" +
//                    "                            class=\"d-flex align-items-center justify-content-center\"\n" +
//                    "                    >\n" +
//                    "                      <svg\n" +
//                    "                              width=\"52\"\n" +
//                    "                              height=\"52\"\n" +
//                    "                              viewBox=\"0 0 52 52\"\n" +
//                    "                              fill=\"none\"\n" +
//                    "                              xmlns=\"http://www.w3.org/2000/svg\"\n" +
//                    "                      >\n" +
//                    "                        <path\n" +
//                    "                                d=\"M46 26V51H6V26\"\n" +
//                    "                                stroke=\"currentColor\"\n" +
//                    "                                stroke-width=\"2\"\n" +
//                    "                                stroke-linecap=\"round\"\n" +
//                    "                                stroke-linejoin=\"round\"\n" +
//                    "                        />\n" +
//                    "                        <path\n" +
//                    "                                d=\"M51 13.5H1V26H51V13.5Z\"\n" +
//                    "                                stroke=\"currentColor\"\n" +
//                    "                                stroke-width=\"2\"\n" +
//                    "                                stroke-linecap=\"round\"\n" +
//                    "                                stroke-linejoin=\"round\"\n" +
//                    "                        />\n" +
//                    "                        <path\n" +
//                    "                                d=\"M26 51V13.5\"\n" +
//                    "                                stroke=\"currentColor\"\n" +
//                    "                                stroke-width=\"2\"\n" +
//                    "                                stroke-linecap=\"round\"\n" +
//                    "                                stroke-linejoin=\"round\"\n" +
//                    "                        />\n" +
//                    "                        <path\n" +
//                    "                                d=\"M26 13.5H14.75C13.0924 13.5 11.5027 12.8415 10.3306 11.6694C9.15848 10.4973 8.5 8.9076 8.5 7.25C8.5 5.5924 9.15848 4.00269 10.3306 2.83058C11.5027 1.65848 13.0924 1 14.75 1C23.5 1 26 13.5 26 13.5Z\"\n" +
//                    "                                stroke=\"currentColor\"\n" +
//                    "                                stroke-width=\"2\"\n" +
//                    "                                stroke-linecap=\"round\"\n" +
//                    "                                stroke-linejoin=\"round\"\n" +
//                    "                        />\n" +
//                    "                        <path\n" +
//                    "                                d=\"M26 13.5H37.25C38.9076 13.5 40.4973 12.8415 41.6694 11.6694C42.8415 10.4973 43.5 8.9076 43.5 7.25C43.5 5.5924 42.8415 4.00269 41.6694 2.83058C40.4973 1.65848 38.9076 1 37.25 1C28.5 1 26 13.5 26 13.5Z\"\n" +
//                    "                                stroke=\"currentColor\"\n" +
//                    "                                stroke-width=\"2\"\n" +
//                    "                                stroke-linecap=\"round\"\n" +
//                    "                                stroke-linejoin=\"round\"\n" +
//                    "                        />\n" +
//                    "                      </svg>\n" +
//                    "                    </span>\n" +
//                    "              </div>\n" +
//                    "              <div class=\"tp-order-details-content\">\n" +
//                    "                <h3 class=\"tp-order-details-title\">Your Order Confirmed</h3>\n" +
//                    "                <p>\n" +
//                    "                  We will send you a shipping confirmation email as soon\n" +
//                    "                  <br />\n" +
//                    "                  as your order ships\n" +
//                    "                </p>\n" +
//                    "              </div>\n" +
//                    "            </div>\n" +
//                    "            <div class=\"tp-order-details-item-wrapper\">\n" +
//                    "              <div class=\"row\">\n" +
//                    "                <div class=\"col-sm-6\">\n" +
//                    "                  <div class=\"tp-order-details-item\">\n" +
//                    "                    <h4>Order Date:</h4>\n" +
//                    "                    <p>" + sdf.format(Timestamp.valueOf(order.getOrderDate())) + "</p>\n" +
//                    "                  </div>\n" +
//                    "                </div>\n" +
//                    "                <div class=\"col-sm-6\">\n" +
//                    "                  <div class=\"tp-order-details-item\">\n" +
//                    "                    <h4>Expected Delivery:</h4>\n" +
//                    "                    <p>" + sdf.format(Timestamp.valueOf(order.getOrderDate().plusDays(7))) + "</p>\n" +
//                    "                  </div>\n" +
//                    "                </div>\n" +
//                    "                <div class=\"col-sm-6\">\n" +
//                    "                  <div class=\"tp-order-details-item\">\n" +
//                    "                    <h4>Order Number:</h4>\n" +
//                    "                    <p>#" + order.getId() + "</p>\n" +
//                    "                  </div>\n" +
//                    "                </div>\n" +
//                    "                <div class=\"col-sm-6\">\n" +
//                    "                  <div class=\"tp-order-details-item\">\n" +
//                    "                    <h4>Order Status:</h4>\n" +
//                    "                    <p>" + order.getOrderStatus() + "</p>\n" +
//                    "                  </div>\n" +
//                    "                </div>\n" +
//                    "              </div>\n" +
//                    "            </div>\n" +
//                    "          </div>\n" +
//                    "        </div>\n" +
//                    "        <div class=\"col-lg-6\">\n" +
//                    "          <div class=\"tp-order-info-wrapper\">\n" +
//                    "            <h4 class=\"tp-order-info-title\">Order Details</h4>\n" +
//                    "\n" +
//                    "            <div class=\"tp-order-info-list\">\n" +
//                    "              <ul>\n" +
//                    "                <!-- header -->\n" +
//                    "                <li class=\"tp-order-info-list-header\">\n" +
//                    "                  <h4>Product</h4>\n" +
//                    "                  <h4>Total</h4>\n" +
//                    "                </li>\n" +
//                    "\n" +
//                    "                <!-- item list -->\n" +
//                    "                {{listItems}}" +
//                    "\n" +
//                    "                <!-- subtotal -->\n" +
//                    "                <li class=\"tp-order-info-list-subtotal\">\n" +
//                    "                  <span>Subtotal</span>\n" +
//                    "                  <span>$"+ (order.getTotal() - order.getDeliveryFee().getFee()) +"</span>\n" +
//                    "                </li>\n" +
//                    "\n" +
//                    "                <!-- shipping -->\n" +
//                    "                <!-- shipping -->\n" +
//                    "                <li class=\"tp-order-info-list-shipping\">\n" +
//                    "                  <span>Shipping</span>\n" +
//                    "                  <div\n" +
//                    "                          class=\"tp-order-info-list-shipping-item d-flex flex-column align-items-end\"\n" +
//                    "                  >\n" +
//                    "                        <span>\n" +
//                    "                          <input id=\"shipping_info\" type=\"checkbox\" checked/>\n" +
//                    "                          <label for=\"shipping_info\"\n" +
//                    "                          >"+order.getDeliveryFee().getCity()+": <span>$"+order.getDeliveryFee().getFee()+"</span></label\n" +
//                    "                          >\n" +
//                    "                        </span>\n" +
//                    "                  </div>\n" +
//                    "                </li>\n" +
//                    "\n" +
//                    "                <!-- total -->\n" +
//                    "                <li class=\"tp-order-info-list-total\">\n" +
//                    "                  <span>Total</span>\n" +
//                    "                  <span>$"+order.getTotal()+"</span>\n" +
//                    "                </li>\n" +
//                    "              </ul>\n" +
//                    "            </div>\n" +
//                    "          </div>\n" +
//                    "        </div>\n" +
//                    "      </div>\n" +
//                    "    </div>\n" +
//                    "  </div>\n" +
//                    "</section>\n" +
//                    "</body>\n" +
//                    "</html>\n";
//
//            StringBuilder listHTML = new StringBuilder();
//            for (OrderItem orderItem : order.getOrderItems()) {
//                listHTML.append("<li class='tp-order-info-list-desc'>").append("<p>"+ orderItem.getProduct().getName()+" <span> x "+orderItem.getQuantity()+"</span></p>").append("<span>$"+orderItem.getPrice()+"</span>").append("</li>");
//            }
//            String replaced = emailContent.replace("{{listItems}}", listHTML.toString());
//
//            emailService.sendEmail(user.getEmail(), "Order Confirmation", replaced);

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
