package com.poojithairosha.shofy.service.admin;

import com.poojithairosha.shofy.exception.CustomException;
import com.poojithairosha.shofy.util.HibernateUtil;
import jakarta.ws.rs.core.Response;
import org.hibernate.Session;

import java.util.HashMap;
import java.util.Map;

public class AdminHomeService {

    public Map<String, Object> getDashboard() {
        HashMap<String, Object> dashboard = new HashMap<>();
        dashboard.put("profit", getProfit());
        dashboard.put("sales", getSales());
        dashboard.put("userCount", getUserCount());
        dashboard.put("productCount", getProductCount());
        return dashboard;
    }

    public Double getProfit() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            session.beginTransaction();
            Double profit = session.createQuery("select sum((o.total - df.fee) * (20/100)) from Order o join DeliveryFee df on o.deliveryFee.id = df.id", Double.class).getSingleResult();
            session.getTransaction().commit();
            return profit;
        } catch (Exception e) {
            throw new CustomException(Response.Status.INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }

    public Double getSales() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            session.beginTransaction();
            Double sales = session.createQuery("select sum(o.total) from Order o", Double.class).getSingleResult();
            session.getTransaction().commit();
            return sales;
        } catch (Exception e) {
            throw new CustomException(Response.Status.INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }

    public Long getUserCount() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            session.beginTransaction();
            Long userCount = session.createQuery("select count(u.id) from User u", Long.class).getSingleResult();
            session.getTransaction().commit();
            return userCount;
        } catch (Exception e) {
            throw new CustomException(Response.Status.INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }

    public Long getProductCount() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            session.beginTransaction();
            Long productCount = session.createQuery("select count(p.id) from Product p", Long.class).getSingleResult();
            session.getTransaction().commit();
            return productCount;
        } catch (Exception e) {
            throw new CustomException(Response.Status.INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }
}
