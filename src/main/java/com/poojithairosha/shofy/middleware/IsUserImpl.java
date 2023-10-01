package com.poojithairosha.shofy.middleware;

import com.poojithairosha.shofy.annotation.IsUser;
import com.poojithairosha.shofy.exception.CustomException;
import com.poojithairosha.shofy.model.user.User;
import com.poojithairosha.shofy.model.user.UserType;
import com.poojithairosha.shofy.service.UserService;
import com.poojithairosha.shofy.util.JwtTokenUtil;
import io.fusionauth.jwt.JWTExpiredException;
import jakarta.inject.Inject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.ws.rs.container.ContainerRequestContext;
import jakarta.ws.rs.container.ContainerRequestFilter;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.Response;
import jakarta.ws.rs.ext.Provider;
import org.glassfish.jersey.server.mvc.Viewable;

import java.io.IOException;
import java.net.URI;

@IsUser
@Provider
public class IsUserImpl implements ContainerRequestFilter {

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
                    containerRequestContext.abortWith(Response.seeOther(URI.create(contextPath + "/auth/login")).build());
                }
            }
        } else {
            containerRequestContext.abortWith(Response.seeOther(URI.create(contextPath + "/auth/login")).build());
        }
    }


    public boolean validateRqHeaderToken(String token) {
        try {
            User user = userService.getUserByEmail(jwtTokenUtil.getUsername(token));
            return jwtTokenUtil.validateToken(token, user) && (user.getUserType() == UserType.USER_LOCAL || user.getUserType() == UserType.USER_GOOGLE);
        } catch (Exception ex) {
            throw new CustomException(Response.Status.UNAUTHORIZED, "You need to login first");
        }
    }
}
