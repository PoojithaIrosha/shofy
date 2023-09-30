package com.poojithairosha.shofy.service;

import com.poojithairosha.shofy.dto.UpdateProfileDTO;
import com.poojithairosha.shofy.exception.CustomException;
import com.poojithairosha.shofy.model.user.User;
import com.poojithairosha.shofy.model.user.UserAddress;
import com.poojithairosha.shofy.util.HibernateUtil;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.Response;
import org.apache.commons.io.FilenameUtils;
import org.glassfish.jersey.media.multipart.FormDataContentDisposition;
import org.hibernate.Session;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

public class UserService {

    @Context
    private HttpServletRequest request;

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
            String fileName = fileMetaData.getFileName();
            String extension = FilenameUtils.getExtension(fileName);
            String path = System.getProperty("user.home") + File.separator + "shofy" + File.separator + "profileimages" + File.separator + user.getEmail() + "." + extension;

            File dirpath = new File(System.getProperty("user.home") + File.separator + "shofy" + File.separator + "profileimages");
            if (!dirpath.exists()) {
                if(!dirpath.mkdirs()) {
                    throw new CustomException(Response.Status.INTERNAL_SERVER_ERROR, "Folder creation failed");
                }
            }

            try {
                int read = 0;
                byte[] bytes = new byte[1024];

                OutputStream out = new FileOutputStream(new File(path));
                while ((read = fileInputStream.read(bytes)) != -1) {
                    out.write(bytes, 0, read);
                }

                out.flush();
                out.close();

                user.setPicture(path);
                Session session = HibernateUtil.getSessionFactory().openSession();
                session.beginTransaction();
                session.merge(user);
                session.getTransaction().commit();

                return "Profile image updated successfully";
            } catch (Exception e) {
                throw new CustomException(Response.Status.INTERNAL_SERVER_ERROR, "Something went wrong");
            }
        } else {
            throw new CustomException(Response.Status.BAD_REQUEST, "User not logged in");
        }
    }
}
