package com.poojithairosha.shofy.service;

import com.poojithairosha.shofy.dto.LoginRespDTO;
import com.poojithairosha.shofy.dto.RPReqDTO;
import com.poojithairosha.shofy.dto.RegisterReqDTO;
import com.poojithairosha.shofy.dto.UpdatePasswordDTO;
import com.poojithairosha.shofy.email.EmailService;
import com.poojithairosha.shofy.exception.CustomException;
import com.poojithairosha.shofy.model.user.User;
import com.poojithairosha.shofy.model.user.UserType;
import com.poojithairosha.shofy.util.Encryption;
import com.poojithairosha.shofy.util.HibernateUtil;
import com.poojithairosha.shofy.util.JwtTokenUtil;
import com.poojithairosha.shofy.util.ThreadPoolExecutorUtil;
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

                EmailService.sendEmail(newUser.getEmail(), "Email Verification - Shofy", "<div style=\"display: flex; flex-direction:column; align-items: center;\">\n" +
                        "      <h1\n" +
                        "        style=\"font-family: monospace; font-weight: bolder\"\n" +
                        "      >\n" +
                        "        SHOFY - Email Verification\n" +
                        "    </h1>\n" +
                        "      <table style=\"font-family: monospace\">\n" +
                        "        <tr>\n" +
                        "          <td>Name:</td>\n" +
                        "          <td>" + newUser.getFirstName() + "</td>\n" +
                        "        </tr>\n" +
                        "        <tr>\n" +
                        "          <td>Email:</td>\n" +
                        "          <td>" + newUser.getEmail() + "</td>\n" +
                        "        </tr>\n" +
                        "      </table>\n" +
                        "      <br />\n" +
                        "      <span style=\"font-family: monospace; color: gray;\">Please verify your email address by pressing the below button</span>\n" +
                        "      <br>\n" +
                        "      <a\n" +
                        "        href=\"http://localhost:8080/shofy/auth/verify-email?code=" + verificationCode + "\"\n" +
                        "        style=\"\n" +
                        "          background-color: crimson;\n" +
                        "          border: none;\n" +
                        "          color: white;\n" +
                        "          padding: 10px 50px;\n" +
                        "          border-radius: 5px;\n" +
                        "          text-decoration: none;\n" +
                        "          text-transform: uppercase;\n" +
                        "          font-family: monospace;\n" +
                        "          letter-spacing: 1px;\n" +
                        "        \"\n" +
                        "        >Verify Email</a\n" +
                        "      >\n" +
                        "    </div>");

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

        return new LoginRespDTO(accessToken, refreshToken, expDate.toString());
    }

    public LoginRespDTO saveGoogleUser(String token) {
        List<JSONWebKey> keys = JSONWebKeySetHelper.retrieveKeysFromJWKS("https://www.googleapis.com/oauth2/v3/certs");
        PublicKey publicKey = JSONWebKey.parse(keys.get(0));

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

                EmailService.sendEmail(email, "Password Reset - Shofy", "<div style=\"display: flex; flex-direction:column; align-items: center;\">\n" +
                        "      <h1\n" +
                        "        style=\"font-family: monospace; font-weight: bolder\"\n" +
                        "      >\n" +
                        "        SHOFY - Password Reset\n" +
                        "    </h1>\n" +
                        "      <table style=\"font-family: monospace\">\n" +
                        "        <tr>\n" +
                        "          <td>Name:</td>\n" +
                        "          <td>" + userByEmail.getFirstName() + "</td>\n" +
                        "        </tr>\n" +
                        "        <tr>\n" +
                        "          <td>Email:</td>\n" +
                        "          <td>" + userByEmail.getEmail() + "</td>\n" +
                        "        </tr>\n" +
                        "      </table>\n" +
                        "      <br />\n" +
                        "      <span style=\"font-family: monospace; color: gray;\">Please press the button RESET PASSWORD</span>\n" +
                        "      <br>\n" +
                        "      <a\n" +
                        "        href=\"http://localhost:8080/shofy/auth/reset-password?code=" + uuid + "\"\n" +
                        "        style=\"\n" +
                        "          background-color: crimson;\n" +
                        "          border: none;\n" +
                        "          color: white;\n" +
                        "          padding: 10px 50px;\n" +
                        "          border-radius: 5px;\n" +
                        "          text-decoration: none;\n" +
                        "          text-transform: uppercase;\n" +
                        "          font-family: monospace;\n" +
                        "          letter-spacing: 1px;\n" +
                        "        \"\n" +
                        "        >Reset Password</a\n" +
                        "      >\n" +
                        "    </div>");

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
}
