package com.poojithairosha.shofy.service;

import com.poojithairosha.shofy.dto.UpdateProfileDTO;
import com.poojithairosha.shofy.exception.CustomException;
import com.poojithairosha.shofy.model.product.Product;
import com.poojithairosha.shofy.model.user.User;
import com.poojithairosha.shofy.model.user.UserAddress;
import com.poojithairosha.shofy.util.HibernateUtil;
import jakarta.inject.Inject;
import jakarta.persistence.criteria.Predicate;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.Response;
import org.apache.commons.io.FilenameUtils;
import org.glassfish.jersey.media.multipart.FormDataContentDisposition;
import org.hibernate.Session;
import org.hibernate.query.criteria.HibernateCriteriaBuilder;
import org.hibernate.query.criteria.JpaCriteriaQuery;
import org.hibernate.query.criteria.JpaRoot;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class UserService {

    @Context
    private HttpServletRequest request;

    @Inject
    private FileUploadService fileUploadService;

    public Map<String, Object> getUsersPagination(Integer page, String search) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            session.beginTransaction();

            List<Predicate> predicatesList = new ArrayList<>();
            List<Predicate> countPredicatesList = new ArrayList<>();

            HibernateCriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
            JpaCriteriaQuery<User> query = criteriaBuilder.createQuery(User.class);
            JpaRoot<User> root = query.from(User.class);

            JpaCriteriaQuery<Long> countQuery = criteriaBuilder.createQuery(Long.class);
            JpaRoot<User> countRoot = countQuery.from(User.class);

            if (!search.equals("all")) {
                predicatesList.add(criteriaBuilder.or(criteriaBuilder.like(criteriaBuilder.lower(root.get("email")), "%" + search.toLowerCase() + "%"), criteriaBuilder.like(criteriaBuilder.lower(root.get("firstName")), "%" + search.toLowerCase() + "%"), criteriaBuilder.like(criteriaBuilder.lower(root.get("lastName")), "%" + search.toLowerCase() + "%"), criteriaBuilder.like(criteriaBuilder.lower(root.get("mobileNumber")), "%" + search.toLowerCase() + "%")));
                countPredicatesList.add(criteriaBuilder.or(criteriaBuilder.like(criteriaBuilder.lower(countRoot.get("email")), "%" + search.toLowerCase() + "%"), criteriaBuilder.like(criteriaBuilder.lower(countRoot.get("firstName")), "%" + search.toLowerCase() + "%"), criteriaBuilder.like(criteriaBuilder.lower(countRoot.get("lastName")), "%" + search.toLowerCase() + "%"), criteriaBuilder.like(criteriaBuilder.lower(countRoot.get("mobileNumber")), "%" + search.toLowerCase() + "%")));
            }

            int pageCount;
            int limit = 6;
            Long count;

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

            List<User> resultList = null;

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
            result.put("users", resultList);
            result.put("search", search);
            result.put("page", page);

            return result;
        } catch (Exception e) {
            throw new CustomException(Response.Status.NOT_FOUND, e.getMessage());
        }
    }

    public User getUserByEmail(String email) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("SELECT u FROM User u WHERE u.email=:email", User.class).setParameter("email", email).uniqueResult();
        } catch (Exception e) {
            throw new CustomException(Response.Status.INTERNAL_SERVER_ERROR, "Something went wrong");
        }
    }

    public User getUserByVerificationCode(String code) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("SELECT u FROM User u WHERE u.verificationCode=:vc", User.class).setParameter("vc", code).uniqueResult();
        } catch (Exception e) {
            throw new CustomException(Response.Status.INTERNAL_SERVER_ERROR, "Something went wrong");
        }
    }

    public User getUserFromSession() {
        User user = (User) request.getSession().getAttribute("user");
        if (user != null) {
            try (Session session = HibernateUtil.getSessionFactory().openSession()) {
                return session.createQuery("from User u where u.email=:email", User.class).setParameter("email", user.getEmail()).uniqueResult();
            } catch (Exception e) {
                throw new CustomException(Response.Status.INTERNAL_SERVER_ERROR, "Something went wrong");
            }
        } else {
            throw new CustomException(Response.Status.BAD_REQUEST, "User not logged in");
        }
    }

    public String updateUser(UpdateProfileDTO dto) {

        User user = (User) request.getSession().getAttribute("user");

        if (user != null) {
            try (Session session = HibernateUtil.getSessionFactory().openSession()) {
                session.beginTransaction();

                User userFromDB = session.createQuery("from User u where u.email=:email", User.class).setParameter("email", user.getEmail()).uniqueResult();

                userFromDB.setFirstName(dto.getFirstName());
                userFromDB.setLastName(dto.getLastName());
                userFromDB.setMobileNumber(dto.getMobileNumber());

                UserAddress userAddress = userFromDB.getUserAddress();
                if (userAddress == null) {
                    userAddress = new UserAddress();
                }

                userAddress.setAddressLine1(dto.getAddressLine1());
                userAddress.setAddressLine2(dto.getAddressLine2());
                userAddress.setCity(dto.getCity());
                userAddress.setZipCode(dto.getZipCode());

                userFromDB.setUserAddress(userAddress);

                session.merge(userFromDB);
                session.getTransaction().commit();
                return "Profile updated successfully";
            } catch (Exception e) {
                throw new CustomException(Response.Status.INTERNAL_SERVER_ERROR, "Something went wrong");
            }
        } else {
            throw new CustomException(Response.Status.BAD_REQUEST, "User not logged in");
        }
    }

    public String updateProfilePicture(InputStream fileInputStream, FormDataContentDisposition fileMetaData) {

        User user = (User) request.getSession().getAttribute("user");

        if (user != null) {

            if(user.getPicture() != null) {
                fileUploadService.deleteFile(user.getPicture());
            }

            String ext = FilenameUtils.getExtension(fileMetaData.getFileName());
            String fileName = user.getEmail() + "." + ext;

            FileUploadService.FileItem profile = fileUploadService.upload("profile", fileInputStream, fileMetaData, fileName);

            user.setPicture(profile.getUrl());
            try (Session session = HibernateUtil.getSessionFactory().openSession()) {
                session.beginTransaction();
                session.merge(user);
                session.getTransaction().commit();

                return "Profile picture updated successfully";
            } catch (Exception e) {
                throw new CustomException(Response.Status.INTERNAL_SERVER_ERROR, e.getMessage());
            }
        } else {
            throw new CustomException(Response.Status.BAD_REQUEST, "User not logged in");
        }
    }

    public String updateUserStatus(Long userId) {
        try(Session session = HibernateUtil.getSessionFactory().openSession()) {
            session.beginTransaction();
            User user = session.get(User.class, userId);
            if(user != null) {
                user.setActive(!user.isActive());
                session.merge(user);
                session.getTransaction().commit();
                return "User status updated successfully";
            } else {
                throw new CustomException(Response.Status.BAD_REQUEST, "No user found with the id provided");
            }
        }catch (Exception e) {
            throw new CustomException(Response.Status.INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }
}
