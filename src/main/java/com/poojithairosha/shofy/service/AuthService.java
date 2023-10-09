package com.poojithairosha.shofy.service;

import com.poojithairosha.shofy.dto.LoginRespDTO;
import com.poojithairosha.shofy.dto.RPReqDTO;
import com.poojithairosha.shofy.dto.RegisterReqDTO;
import com.poojithairosha.shofy.dto.UpdatePasswordDTO;
import com.poojithairosha.shofy.exception.CustomException;
import com.poojithairosha.shofy.mail.EmailVerificationMail;
import com.poojithairosha.shofy.mail.ForgotPasswordMail;
import com.poojithairosha.shofy.model.user.User;
import com.poojithairosha.shofy.model.user.UserType;
import com.poojithairosha.shofy.provider.MailServiceProvider;
import com.poojithairosha.shofy.util.Encryption;
import com.poojithairosha.shofy.util.HibernateUtil;
import com.poojithairosha.shofy.util.JwtTokenUtil;
import io.fusionauth.jwks.JSONWebKeySetHelper;
import io.fusionauth.jwks.domain.JSONWebKey;
import io.fusionauth.jwt.Verifier;
import io.fusionauth.jwt.domain.JWT;
import io.fusionauth.jwt.rsa.RSAVerifier;
import jakarta.inject.Inject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.Response;
import org.glassfish.jersey.server.mvc.Viewable;
import org.hibernate.Session;

import java.security.PublicKey;
import java.util.Date;
import java.util.List;
import java.util.UUID;

public class AuthService {

    @Inject
    UserService userService;

    @Inject
    JwtTokenUtil jwtTokenUtil;

    @Context
    HttpServletRequest request;

    public String saveUser(RegisterReqDTO registerReqDTO) {

        User user = userService.getUserByEmail(registerReqDTO.getEmail());

        if (user == null) {
            User newUser = new User();
            newUser.setFirstName(registerReqDTO.getFirst_name());
            newUser.setLastName(registerReqDTO.getLast_name());
            newUser.setMobileNumber(registerReqDTO.getMobile());
            newUser.setEmail(registerReqDTO.getEmail());
            newUser.setPassword(Encryption.encrypt(registerReqDTO.getPassword()));

            String verificationCode = UUID.randomUUID().toString();
            newUser.setVerificationCode(verificationCode);

            try (Session session = HibernateUtil.getSessionFactory().openSession()) {
                session.beginTransaction();
                session.persist(newUser);
                session.getTransaction().commit();

                MailServiceProvider.getInstance().sendMail(new EmailVerificationMail(newUser.getEmail(), verificationCode, newUser.getFirstName(), newUser.getEmail()));

                return "New user registered successfully";
            } catch (CustomException customException) {
                throw customException;
            } catch (Exception e) {
                throw new CustomException(Response.Status.INTERNAL_SERVER_ERROR, "Error occurred while saving user");
            }
        } else {
            throw new CustomException(Response.Status.BAD_REQUEST, "You have already registered with the email provided");
        }
    }

    public LoginRespDTO getLoginRespDTO(User user) {
        String accessToken = jwtTokenUtil.generateAccessToken(user);
        String refreshToken = jwtTokenUtil.generateRefreshToken(user);
        Date expDate = jwtTokenUtil.getExpireDate(accessToken);

        return new LoginRespDTO(accessToken, refreshToken, String.valueOf(expDate.getTime()));
    }

    public LoginRespDTO saveGoogleUser(String token) {
        List<JSONWebKey> keys = JSONWebKeySetHelper.retrieveKeysFromJWKS("https://www.googleapis.com/oauth2/v3/certs");

        PublicKey publicKey = JSONWebKey.parse(keys.get(1));

        Verifier verifier = RSAVerifier.newVerifier(publicKey);
        JWT jwt = JWT.getDecoder().decode(token, verifier);

        String email = jwt.getString("email");
        String firstName = jwt.getString("given_name");
        String lastName = jwt.getString("family_name");
        Boolean emailVerified = jwt.getBoolean("email_verified");

        String picture = jwt.getString("picture");

        User user = userService.getUserByEmail(email);

        if (user == null) {
            User newUser = new User();
            newUser.setFirstName(firstName);
            newUser.setLastName(lastName);
            newUser.setEmail(email);
            newUser.setUserType(UserType.USER_GOOGLE);
            newUser.setGoogleId(jwt.getString("sub"));
            newUser.setPicture(picture);
            newUser.setEmailVerifiedAt(emailVerified ? new Date().toString() : null);
            newUser.setActive(true);

            try (Session session = HibernateUtil.getSessionFactory().openSession()) {
                session.beginTransaction();
                session.persist(newUser);
                session.getTransaction().commit();

                LoginRespDTO loginRespDTO = getLoginRespDTO(newUser);

                request.getSession().setAttribute("access_token", loginRespDTO.getAccessToken());
                request.getSession().setAttribute("user", newUser);

                return loginRespDTO;
            } catch (Exception e) {
                throw new CustomException(Response.Status.INTERNAL_SERVER_ERROR, "Error occurred while saving user");
            }
        } else {
            if (user.getUserType() == UserType.USER_GOOGLE) {

                if (!user.isActive()) {
                    throw new CustomException(Response.Status.BAD_REQUEST, "Your account has been disabled temporary");
                }

                user.setFirstName(firstName);
                user.setLastName(lastName);
                user.setEmail(email);
                user.setGoogleId(jwt.getString("sub"));
                user.setPicture(picture);

                try (Session session = HibernateUtil.getSessionFactory().openSession()) {
                    session.beginTransaction();
                    session.merge(user);
                    session.refresh(user);
                    session.getTransaction().commit();
                } catch (Exception e) {
                    throw new CustomException(Response.Status.INTERNAL_SERVER_ERROR, e.getMessage());
                }

                try {
                    LoginRespDTO loginRespDTO = getLoginRespDTO(user);

                    request.getSession().setAttribute("access_token", loginRespDTO.getAccessToken());
                    request.getSession().setAttribute("user", user);

                    return loginRespDTO;
                } catch (Exception e) {
                    throw new CustomException(Response.Status.INTERNAL_SERVER_ERROR, "Error occurred while saving user");
                }
            } else {
                throw new CustomException(Response.Status.BAD_REQUEST, "You have already registered with the email provided");
            }
        }
    }


    public LoginRespDTO login(String email, String password) {
        try {
            User user = userService.getUserByEmail(email);
            if (user != null && user.getUserType() == UserType.USER_LOCAL) {
                if (Encryption.verifyPassword(password, user.getPassword())) {
                    if (user.getEmailVerifiedAt() != null) {
                        if (!user.isActive()) {
                            throw new CustomException(Response.Status.BAD_REQUEST, "Your account has been disabled temporary");
                        }
                        LoginRespDTO loginRespDTO = getLoginRespDTO(user);

                        request.getSession().setAttribute("access_token", loginRespDTO.getAccessToken());
                        request.getSession().setAttribute("user", user);

                        return loginRespDTO;
                    } else {
                        throw new CustomException(Response.Status.UNAUTHORIZED, "Please verify your email address first");
                    }
                } else {
                    throw new CustomException(Response.Status.UNAUTHORIZED, "Invalid email or password");
                }
            } else {
                throw new CustomException(Response.Status.BAD_REQUEST, "No user found with the email provided");
            }
        } catch (CustomException customException) {
            throw customException;
        } catch (Exception e) {
            throw new CustomException(Response.Status.INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }

    public Viewable verifyEmail(String code) {
        try {
            User user = userService.getUserByVerificationCode(code);
            if (user != null) {
                user.setEmailVerifiedAt(new Date().toString());
                user.setVerificationCode(null);
                user.setActive(true);

                try (Session session = HibernateUtil.getSessionFactory().openSession()) {
                    session.beginTransaction();
                    session.merge(user);
                    session.getTransaction().commit();

                    return new Viewable("/frontend/emails/email-verified");
                }
            } else {
                throw new CustomException(Response.Status.BAD_REQUEST, "Invalid verification code");
            }
        } catch (CustomException customException) {
            throw customException;
        } catch (Exception e) {
            throw new CustomException(Response.Status.INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }

    public String forgotPassword(String email) {

        try {
            User userByEmail = userService.getUserByEmail(email);
            if (userByEmail != null) {

                String uuid = UUID.randomUUID().toString();
                userByEmail.setVerificationCode(uuid);

                try (Session session = HibernateUtil.getSessionFactory().openSession()) {
                    session.beginTransaction();
                    session.merge(userByEmail);
                    session.getTransaction().commit();
                } catch (Exception e) {
                    throw new CustomException(Response.Status.INTERNAL_SERVER_ERROR, "Error occurred while resetting password");
                }

                ForgotPasswordMail forgotPasswordMail = new ForgotPasswordMail(email, uuid, userByEmail.getFirstName(), userByEmail.getEmail());
                MailServiceProvider.getInstance().sendMail(forgotPasswordMail);

                return "Password reset link sent to your email";
            } else {
                throw new CustomException(Response.Status.BAD_REQUEST, "No user found with the email provided");
            }
        } catch (CustomException customException) {
            throw customException;
        } catch (Exception e) {
            throw new CustomException(Response.Status.INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }

    public String resetPassword(RPReqDTO dto) {
        User user = userService.getUserByVerificationCode(dto.getCode());

        if (user != null) {
            user.setPassword(Encryption.encrypt(dto.getPassword()));
            user.setVerificationCode(null);

            try (Session session = HibernateUtil.getSessionFactory().openSession()) {
                session.beginTransaction();
                session.merge(user);
                session.getTransaction().commit();
                return "Password reset successfully";
            } catch (Exception e) {
                throw new CustomException(Response.Status.INTERNAL_SERVER_ERROR, "Error occurred while resetting password");
            }
        } else {
            throw new CustomException(Response.Status.BAD_REQUEST, "Invalid verification code");
        }
    }

    public String updatePassword(UpdatePasswordDTO dto) {
        User user = userService.getUserByEmail(dto.getEmail());

        if (user != null && (dto.getNewPassword().equals(dto.getConfirmPassword())) && Encryption.verifyPassword(dto.getOldPassword(), user.getPassword())) {
            user.setPassword(Encryption.encrypt(dto.getNewPassword()));

            try (Session session = HibernateUtil.getSessionFactory().openSession()) {
                session.beginTransaction();
                session.merge(user);
                session.getTransaction().commit();
                return "Password updated successfully";
            } catch (Exception e) {
                throw new CustomException(Response.Status.INTERNAL_SERVER_ERROR, "Error occurred while updating password");
            }
        } else {
            throw new CustomException(Response.Status.BAD_REQUEST, "Invalid verification code");
        }
    }

    public String logout() {
        try {
            request.getSession().invalidate();
            return "success";
        } catch (Exception e) {
            throw new CustomException(Response.Status.INTERNAL_SERVER_ERROR, "Error occurred while logging out");
        }
    }

    public LoginRespDTO refreshToken(String refreshToken) {
        if (refreshToken != null) {
            User user = userService.getUserByEmail(jwtTokenUtil.getUsername(refreshToken));

            if (user == null || !jwtTokenUtil.validateToken(refreshToken, user)) {
                throw new CustomException(Response.Status.UNAUTHORIZED, "Invalid refresh token");
            } else {
                String accessToken = jwtTokenUtil.generateAccessToken(user);
                Date expireDate = jwtTokenUtil.getExpireDate(accessToken);

                request.getSession().setAttribute("access_token", accessToken);
                request.getSession().setAttribute("user", user);

                return new LoginRespDTO(accessToken, refreshToken, String.valueOf(expireDate.getTime()));
            }
        }else {
            throw new CustomException(Response.Status.BAD_REQUEST, "Refresh token not found");
        }
    }
}