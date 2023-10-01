package com.poojithairosha.shofy.service;

import com.poojithairosha.shofy.exception.CustomException;
import com.poojithairosha.shofy.model.order.Order;
import com.poojithairosha.shofy.model.user.User;
import com.poojithairosha.shofy.util.HibernateUtil;
import jakarta.persistence.criteria.Predicate;
import jakarta.ws.rs.core.Response;
import org.hibernate.Session;
import org.hibernate.query.criteria.HibernateCriteriaBuilder;
import org.hibernate.query.criteria.JpaCriteriaQuery;
import org.hibernate.query.criteria.JpaRoot;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class OrderService {

    public List<Order> getOrders(User user) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            session.beginTransaction();
            List<Order> orderList = session.createQuery("from Order o where o.user.id = :userId order by o.orderDate desc", Order.class).setParameter("userId", user.getId()).list();
            session.getTransaction().commit();
            return orderList;
        } catch (CustomException e) {
            throw e;
        } catch (Exception e) {
            throw new CustomException(Response.Status.INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }

    public Order getOrderByOrderId(String orderId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            session.beginTransaction();
            Order order = session.createQuery("from Order o where o.orderId = :orderId", Order.class).setParameter("orderId", orderId).uniqueResult();
            session.getTransaction().commit();
            return order;
        } catch (CustomException e) {
            throw e;
        } catch (Exception e) {
            throw new CustomException(Response.Status.INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }

    public Map<String, Object> getOrdersPagination(Integer page) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            session.beginTransaction();

            HibernateCriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
            JpaCriteriaQuery<Order> query = criteriaBuilder.createQuery(Order.class);
            JpaRoot<Order> root = query.from(Order.class);

            JpaCriteriaQuery<Long> countQuery = criteriaBuilder.createQuery(Long.class);
            JpaRoot<Order> countRoot = countQuery.from(Order.class);

            query.orderBy(criteriaBuilder.desc(root.get("orderDate")));
            countQuery.orderBy(criteriaBuilder.desc(countRoot.get("orderDate")));

            int pageCount;
            int limit = 6;
            Long count;

            countQuery.select(criteriaBuilder.count(countRoot));
            count = session.createQuery(countQuery).uniqueResult();
            pageCount = (int) Math.ceil((double) count / limit);


            if (page > pageCount) {
                throw new CustomException(Response.Status.NOT_FOUND, "Page does not exist");
            }

            List<Order> resultList = session.createQuery(query.select(root))
                    .setFirstResult((page > 0 ? page - 1 : 0) * limit)
                    .setMaxResults(limit)
                    .getResultList();

            session.getTransaction().commit();

            Map<String, Object> result = new HashMap<>();
            result.put("count", pageCount);
            result.put("orders", resultList);
            result.put("page", page);

            return result;
        } catch (Exception e) {
            throw new CustomException(Response.Status.NOT_FOUND, e.getMessage());
        }
    }

}
