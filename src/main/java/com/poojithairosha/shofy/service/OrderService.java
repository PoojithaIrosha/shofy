package com.poojithairosha.shofy.service;

import com.poojithairosha.shofy.exception.CustomException;
import com.poojithairosha.shofy.model.order.Order;
import com.poojithairosha.shofy.model.user.User;
import com.poojithairosha.shofy.util.HibernateUtil;
import jakarta.ws.rs.core.Response;
import org.hibernate.Session;

import java.util.List;

public class OrderService {

    public List<Order> getOrders(User user) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            session.beginTransaction();
            List<Order> orderList = session.createQuery("from Order o where o.user.id = :userId order by o.orderDate desc", Order.class).setParameter("userId", user.getId()).list();
            session.getTransaction().commit();
            return orderList;
        }catch (CustomException e) {
            throw e;
        }catch (Exception e) {
            throw new CustomException(Response.Status.INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }

    public Order getOrderByOrderId(String orderId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            session.beginTransaction();
            Order order = session.createQuery("from Order o where o.orderId = :orderId", Order.class).setParameter("orderId", orderId).uniqueResult();
            session.getTransaction().commit();
            return order;
        }catch (CustomException e) {
            throw e;
        }catch (Exception e) {
            throw new CustomException(Response.Status.INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }

}
