package com.poojithairosha.shofy.service;

import com.poojithairosha.shofy.exception.CustomException;
import com.poojithairosha.shofy.model.product.Product;
import com.poojithairosha.shofy.util.HibernateUtil;
import jakarta.persistence.criteria.Predicate;
import jakarta.ws.rs.core.Response;
import org.glassfish.jersey.server.mvc.Viewable;
import org.hibernate.Session;
import org.hibernate.query.criteria.HibernateCriteriaBuilder;
import org.hibernate.query.criteria.JpaCriteriaQuery;
import org.hibernate.query.criteria.JpaRoot;

import java.util.*;

public class ProductService {

    public List<Product> getProducts() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            session.beginTransaction();
            List<Product> resultList = session.createQuery("from Product", Product.class).getResultList();
            session.getTransaction().commit();
            return resultList;
        } catch (Exception e) {
            throw new CustomException(Response.Status.INTERNAL_SERVER_ERROR, "Product fetching failed");
        }
    }

    public Map<String, Object> getProductsPagination(Integer page, String search) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            session.beginTransaction();

            List<Predicate> predicatesList = new ArrayList<>();
            List<Predicate> countPredicatesList = new ArrayList<>();

            HibernateCriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
            JpaCriteriaQuery<Product> query = criteriaBuilder.createQuery(Product.class);
            JpaRoot<Product> root = query.from(Product.class);

            JpaCriteriaQuery<Long> countQuery = criteriaBuilder.createQuery(Long.class);
            JpaRoot<Product> countRoot = countQuery.from(Product.class);

            if (!search.equals("all")) {
                predicatesList.add(criteriaBuilder.or(criteriaBuilder.like(criteriaBuilder.lower(root.get("name")), "%" + search.toLowerCase() + "%"), criteriaBuilder.like(criteriaBuilder.lower(root.get("description")), "%" + search.toLowerCase() + "%")));
                countPredicatesList.add(criteriaBuilder.or(criteriaBuilder.like(criteriaBuilder.lower(countRoot.get("name")), "%" + search.toLowerCase() + "%"), criteriaBuilder.like(criteriaBuilder.lower(countRoot.get("description")), "%" + search.toLowerCase() + "%")));
            }

            int pageCount = 0;
            int limit = 2;
            Long count = null;

            if (predicatesList.isEmpty()) {
                countQuery.select(criteriaBuilder.count(countRoot));
                count = session.createQuery(countQuery).uniqueResult();
                pageCount = (int) Math.ceil((double) count / limit);
            } else {
                countQuery.select(criteriaBuilder.count(countRoot)).where(criteriaBuilder.and(countPredicatesList.toArray(new Predicate[0])));
                count = session.createQuery(countQuery).uniqueResult();
                pageCount = (int) Math.ceil((double) count / limit);
            }


            if (page > pageCount) {
                throw new CustomException(Response.Status.NOT_FOUND, "Page does not exist");
            }

            List<Product> resultList = null;

            if (predicatesList.isEmpty()) {
                resultList = session.createQuery(query.select(root))
                        .setFirstResult((page > 0 ? page - 1 : 0) * limit)
                        .setMaxResults(limit)
                        .getResultList();
            } else {
                query.select(root).where(criteriaBuilder.and(predicatesList.toArray(new Predicate[0])));
                resultList = session.createQuery(query)
                        .setFirstResult((page > 0 ? page - 1 : 0) * limit)
                        .setMaxResults(limit)
                        .getResultList();
            }
            session.getTransaction().commit();

            Map<String, Object> result = new HashMap<>();
            result.put("count", pageCount);
            result.put("products", resultList);
            result.put("search", search);
            result.put("page", page);

            return result;
        } catch (Exception e) {
            throw new CustomException(Response.Status.NOT_FOUND, e.getMessage());
        }
    }

    public String addProduct(Product product) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {

            Product productResult = session.createQuery("from Product p where p.name = :name", Product.class).setParameter("name", product.getName()).uniqueResult();
            if (productResult != null) {
                throw new CustomException(Response.Status.BAD_REQUEST, "Product already exists");
            }

            session.beginTransaction();
            session.persist(product);
            session.getTransaction().commit();
            return "Product added successfully";
        } catch (CustomException e) {
            throw e;
        } catch (Exception e) {
            throw new CustomException(Response.Status.INTERNAL_SERVER_ERROR, "Product adding failed");
        }
    }


    public Product getProductById(Long id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.get(Product.class, id);
        } catch (Exception e) {
            throw new CustomException(Response.Status.INTERNAL_SERVER_ERROR, "Product fetching failed");
        }
    }

    public Integer getProductQty(Long id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Product product = session.get(Product.class, id);
            return product.getQuantity();

        } catch (Exception e) {
            throw new CustomException(Response.Status.INTERNAL_SERVER_ERROR, "Product fetching failed");
        }
    }
}
