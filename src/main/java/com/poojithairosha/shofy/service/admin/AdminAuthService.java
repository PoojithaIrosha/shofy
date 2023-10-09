package com.poojithairosha.shofy.service.admin;

import com.poojithairosha.shofy.dto.LoginRespDTO;
import com.poojithairosha.shofy.exception.CustomException;
import com.poojithairosha.shofy.model.user.User;
import com.poojithairosha.shofy.model.user.UserType;
import com.poojithairosha.shofy.service.UserService;
import com.poojithairosha.shofy.util.Encryption;
import com.poojithairosha.shofy.util.JwtTokenUtil;
import jakarta.inject.Inject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.Response;

import java.util.Date;

public class AdminAuthService {

    @Inject
    private UserService userService;

    @Inject
    private JwtTokenUtil jwtTokenUtil;

    @Context
    private HttpServletRequest request;

    public LoginRespDTO login(String email, String password) {
        try {
            User user = userService.getUserByEmail(email);
            if (user != null && user.getUserType() == UserType.ADMIN) {
                if (Encryption.verifyPassword(password, user.getPassword())) {
                    if (user.getEmailVerifiedAt() != null) {

                        if(!user.isActive()) {
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
                throw new CustomException(Response.Status.BAD_REQUEST, "No admin found with the email provided");
            }
        } catch (CustomException customException) {
            throw customException;
        } catch (Exception e) {
            throw new CustomException(Response.Status.INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }

    public LoginRespDTO getLoginRespDTO(User user) {
        String accessToken = jwtTokenUtil.generateAccessToken(user);
        String refreshToken = jwtTokenUtil.generateRefreshToken(user);
        Date expDate = jwtTokenUtil.getExpireDate(accessToken);

        return new LoginRespDTO(accessToken, refreshToken, String.valueOf(expDate.getTime()));
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
