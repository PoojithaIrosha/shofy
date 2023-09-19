package com.poojithairosha.shofy.service;

import com.poojithairosha.shofy.exception.CustomException;
import com.poojithairosha.shofy.model.cart.Cart;
import com.poojithairosha.shofy.model.cart.CartItem;
import com.poojithairosha.shofy.model.product.Product;
import com.poojithairosha.shofy.model.user.User;
import com.poojithairosha.shofy.util.HibernateUtil;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.Response;
import org.hibernate.Session;

import java.util.List;
import java.util.concurrent.atomic.AtomicBoolean;

public class CartService {

    @Context
    private HttpServletRequest request;

    public String addProduct(Long productId, Integer quantity) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            session.beginTransaction();

            User user = (User) request.getSession().getAttribute("user");

            if (user != null) {
                Cart cart = session.createQuery("from Cart c join User u on c.user.id = u.id where u.id = :id", Cart.class)
                        .setParameter("id", user.getId())
                        .uniqueResult();

                Product product = session.createQuery("from Product p where p.id = :id", Product.class)
                        .setParameter("id", productId)
                        .uniqueResult();


                if (cart == null) {
                    cart = new Cart();
                    cart.setUser(user);

                    CartItem cartItem = new CartItem(product, quantity, cart);
                    cart.setCartItems(List.of(cartItem));
                    cart.setTotal(cartItem.getProduct().getPrice() * cartItem.getQuantity());

                    session.persist(cart);
                } else {
                    AtomicBoolean isProductFound = new AtomicBoolean(false);

                    cart.getCartItems().forEach(cartItem -> {
                        if (cartItem.getProduct().getId() == productId) {
                            if ((quantity + cartItem.getQuantity()) <= product.getQuantity()) {
                                cartItem.setQuantity(cartItem.getQuantity() + quantity);
                                isProductFound.set(true);
                            } else {
                                throw new CustomException(Response.Status.BAD_REQUEST, "Product quantity is low. Can't add " + quantity + " of " + product.getName() + " to the cart at the moment");
                            }
                        }
                    });

                    if (!isProductFound.get()) {
                        if (quantity <= product.getQuantity()) {
                            CartItem cartItem = new CartItem(product, quantity, cart);
                            cart.getCartItems().add(cartItem);
                        } else {
                            throw new CustomException(Response.Status.BAD_REQUEST, "Product quantity is low. Can't purchase " + quantity + " of " + product.getName() + " at the moment");
                        }
                    }

                    cart.setTotal(cart.getTotal() + (product.getPrice() * quantity));

                    session.merge(cart);
                }
                session.getTransaction().commit();

                return "Product added to cart";
            } else {
                throw new CustomException(Response.Status.BAD_REQUEST, "User not found");
            }
        } catch (CustomException exception) {
            throw exception;
        } catch (Exception e) {
            throw new CustomException(Response.Status.INTERNAL_SERVER_ERROR, "Error occurred while adding product to cart");
        }
    }

    public Cart getCart() {

        User user = (User) request.getSession().getAttribute("user");

        if (user != null) {
            try (Session session = HibernateUtil.getSessionFactory().openSession()) {
                session.beginTransaction();
                Cart cart = session.createQuery("from Cart c where c.user.id=:id", Cart.class)
                        .setParameter("id", user.getId())
                        .uniqueResult();
                session.getTransaction().commit();
                return cart;
            } catch (Exception e) {
                throw new CustomException(Response.Status.INTERNAL_SERVER_ERROR, "Error occurred while getting cart");
            }
        } else {
            throw new CustomException(Response.Status.BAD_REQUEST, "User not found");
        }

    }

    public String deleteCartItem(Long cartId, Long cartItemId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            session.beginTransaction();

            Cart cart = session.createQuery("from Cart c where c.id = :id", Cart.class)
                    .setParameter("id", cartId)
                    .uniqueResult();

            if (cart != null) {
                cart.getCartItems().stream().filter(cartItem -> cartItem.getId() == cartItemId).findFirst().ifPresent(cartItem -> {
                    cart.getCartItems().remove(cartItem);
                    cart.setTotal(cart.getTotal() - (cartItem.getProduct().getPrice() * cartItem.getQuantity()));
                    session.remove(cartItem);
                });
                session.merge(cart);
                session.getTransaction().commit();
                return "Cart item deleted";
            } else {
                throw new CustomException(Response.Status.BAD_REQUEST, "Cart not found");
            }
        } catch (CustomException exception) {
            throw exception;
        } catch (Exception e) {
            throw new CustomException(Response.Status.INTERNAL_SERVER_ERROR, "Error occurred while deleting cart item");
        }
    }

    public String updateQty(Long id, Integer qty) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {

            CartItem cartItem = session.find(CartItem.class, id);

            if(cartItem != null) {
                session.beginTransaction();

                Integer oldQty = cartItem.getQuantity();

                if(oldQty > qty) {
                    cartItem.getCart().setTotal(cartItem.getCart().getTotal() - (cartItem.getProduct().getPrice() * (oldQty - qty)));
                }else {
                    cartItem.getCart().setTotal(cartItem.getCart().getTotal() + (cartItem.getProduct().getPrice() * (qty - oldQty)));
                }

                cartItem.setQuantity(qty);

                session.merge(cartItem);
                session.getTransaction().commit();
                return "success";
            }else {
                throw new CustomException(Response.Status.BAD_REQUEST, "Cart Item Not Found");
            }

        }catch (Exception e) {
            throw new CustomException(Response.Status.INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }
}
