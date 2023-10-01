package com.poojithairosha.shofy.service;

import com.poojithairosha.shofy.dto.UpdateProfileDTO;
import com.poojithairosha.shofy.exception.CustomException;
import com.poojithairosha.shofy.model.user.User;
import com.poojithairosha.shofy.model.user.UserAddress;
import com.poojithairosha.shofy.util.HibernateUtil;
import jakarta.inject.Inject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.Response;
import org.apache.commons.io.FilenameUtils;
import org.glassfish.jersey.media.multipart.FormDataContentDisposition;
import org.hibernate.Session;

import java.io.InputStream;

public class UserService {

    @Context
    private HttpServletRequest request;

    @Inject
    private FileUploadService fileUploadService;

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
}
