package com.poojithairosha.shofy.middleware;

import com.poojithairosha.shofy.annotation.IsAdmin;
import com.poojithairosha.shofy.exception.CustomException;
import com.poojithairosha.shofy.model.user.User;
import com.poojithairosha.shofy.model.user.UserType;
import com.poojithairosha.shofy.service.UserService;
import com.poojithairosha.shofy.util.JwtTokenUtil;
import io.fusionauth.jwt.JWTExpiredException;
import jakarta.annotation.Priority;
import jakarta.inject.Inject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.ws.rs.container.ContainerRequestContext;
import jakarta.ws.rs.container.ContainerRequestFilter;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.Response;
import jakarta.ws.rs.ext.Provider;

import java.io.IOException;
import java.net.URI;

@IsAdmin
@Provider
@Priority(1)
public class IsAdminImpl implements ContainerRequestFilter {

    @Inject
    private UserService userService;

    @Inject
    private JwtTokenUtil jwtTokenUtil;

    @Context
    HttpServletRequest request;

    @Override
    public void filter(ContainerRequestContext containerRequestContext) throws IOException {
        String contextPath = request.getContextPath();

        String token = null;

        if (containerRequestContext.getHeaders().getFirst("Authorization") != null) {
            token = containerRequestContext.getHeaders().getFirst("Authorization").split(" ")[1];
            if (token != null) {
                if (!validateRqHeaderToken(token)) {
                    containerRequestContext.abortWith(Response.status(Response.Status.UNAUTHORIZED).entity("You need to login first").build());
                }
            }
        } else if (request.getSession().getAttribute("access_token") != null) {
            token = (String) request.getSession().getAttribute("access_token");
            if (token != null) {
                if (!validateRqHeaderToken(token)) {
                    containerRequestContext.abortWith(Response.seeOther(URI.create(contextPath + "/admin/login")).build());
                }
            }
        } else {
            containerRequestContext.abortWith(Response.seeOther(URI.create(contextPath + "/admin/login")).build());
        }
    }

    public boolean validateRqHeaderToken(String token) {
        try {
            User user = userService.getUserByEmail(jwtTokenUtil.getUsername(token));
            return jwtTokenUtil.validateToken(token, user) && (user.getUserType() == UserType.ADMIN);
        } catch (JWTExpiredException ex) {
            User user = (User) request.getSession().getAttribute("user");
            String accessToken = jwtTokenUtil.generateAccessToken(user);
            request.getSession().setAttribute("access_token", accessToken);
            return true;
        }catch (Exception ex) {
            throw new CustomException(Response.Status.UNAUTHORIZED, "You need to login first");
        }
    }
}
