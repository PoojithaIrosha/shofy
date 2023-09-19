package com.poojithairosha.shofy.service;

import com.poojithairosha.shofy.exception.CustomException;
import com.poojithairosha.shofy.model.cart.Cart;
import com.poojithairosha.shofy.model.product.Product;
import com.poojithairosha.shofy.model.user.User;
import com.poojithairosha.shofy.model.wishlist.Wishlist;
import com.poojithairosha.shofy.model.wishlist.WishlistItem;
import com.poojithairosha.shofy.util.HibernateUtil;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.Response;
import org.hibernate.Session;

import java.util.List;

public class WishlistService {

    @Context
    private HttpServletRequest request;

    public Wishlist getWishlist() {

        User user = (User) request.getSession().getAttribute("user");

        if (user != null) {
            try (Session session = HibernateUtil.getSessionFactory().openSession()) {
                session.beginTransaction();
                Wishlist wishlist = session.createQuery("from Wishlist w where w.user.id=:id", Wishlist.class)
                        .setParameter("id", user.getId())
                        .uniqueResult();
                session.getTransaction().commit();
                return wishlist;
            } catch (Exception e) {
                throw new CustomException(Response.Status.INTERNAL_SERVER_ERROR, "Error occurred while getting wishlist");
            }
        } else {
            throw new CustomException(Response.Status.BAD_REQUEST, "User not found");
        }

    }

    public String addProduct(Long productId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            session.beginTransaction();

            User user = (User) request.getSession().getAttribute("user");

            if (user != null) {
                Wishlist wishlist = session.createQuery("from Wishlist w join User u on w.user.id = u.id where u.id = :id", Wishlist.class)
                        .setParameter("id", user.getId())
                        .uniqueResult();

                Product product = session.createQuery("from Product p where p.id = :id", Product.class)
                        .setParameter("id", productId)
                        .uniqueResult();


                if (wishlist == null) {
                    wishlist = new Wishlist();
                    wishlist.setUser(user);

                    WishlistItem wishlistItem = new WishlistItem(product, wishlist);
                    wishlist.setWishlistItems(List.of(wishlistItem));

                    session.persist(wishlist);
                } else {

                    wishlist.getWishlistItems().forEach(wishlistItem -> {
                        if (wishlistItem.getProduct().getId() == productId) {
                            throw new CustomException(Response.Status.BAD_REQUEST, "Product already added to wishlist");
                        }
                    });


                    WishlistItem wishlistItem = new WishlistItem(product, wishlist);
                    wishlist.getWishlistItems().add(wishlistItem);

                    session.merge(wishlist);
                }
                session.getTransaction().commit();

                return "Product added to wishlist";
            } else {
                throw new CustomException(Response.Status.BAD_REQUEST, "User not found");
            }
        } catch (CustomException exception) {
            throw exception;
        } catch (Exception e) {
            throw new CustomException(Response.Status.INTERNAL_SERVER_ERROR, "Error occurred while adding product to wishlist");
        }
    }

    public String deleteWishlistItem(Long wishlistId, Long wishlistItemId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            session.beginTransaction();

            Wishlist wishlist = session.createQuery("from Wishlist w where w.id = :id", Wishlist.class)
                    .setParameter("id", wishlistId)
                    .uniqueResult();

            if (wishlist != null) {
                wishlist.getWishlistItems().stream().filter(wishlistItem -> wishlistItem.getId() == wishlistItemId).findFirst().ifPresent(wishlistItem -> {
                    wishlist.getWishlistItems().remove(wishlistItem);
                    session.remove(wishlistItem);
                });
                session.merge(wishlist);
                session.getTransaction().commit();
                return "Wishlist item deleted";
            } else {
                throw new CustomException(Response.Status.BAD_REQUEST, "Wishlist not found");
            }
        } catch (CustomException exception) {
            throw exception;
        } catch (Exception e) {
            throw new CustomException(Response.Status.INTERNAL_SERVER_ERROR, "Error occurred while deleting wishlist item");
        }
    }
}
