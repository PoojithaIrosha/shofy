package com.poojithairosha.shofy.controller;

import com.poojithairosha.shofy.annotation.IsUser;
import com.poojithairosha.shofy.dto.LoginRespDTO;
import com.poojithairosha.shofy.dto.RPReqDTO;
import com.poojithairosha.shofy.dto.RegisterReqDTO;
import com.poojithairosha.shofy.dto.UpdatePasswordDTO;
import com.poojithairosha.shofy.model.user.User;
import com.poojithairosha.shofy.service.AuthService;
import jakarta.inject.Inject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import org.glassfish.jersey.server.mvc.Viewable;

import javax.swing.text.View;
import java.net.URI;
import java.util.Date;

@Path("/auth")
public class AuthController {

    @Inject
    AuthService authService;

    @Context
    HttpServletRequest request;

    @Path("/login")
    @GET
    @Produces(MediaType.TEXT_HTML)
    public Viewable login() {
        return new Viewable("/frontend/auth/login");
    }

    @Path("/login")
    @POST
    @Produces(MediaType.APPLICATION_JSON)
    public Response loginAction(@FormParam("email") String email, @FormParam("password") String password) {
        return Response.ok().entity(authService.login(email, password)).build();
    }

    @Path("/google")
    @POST
    @Produces(MediaType.APPLICATION_JSON)
    public Response googleAction(@FormParam("idtoken") String token) {
        return Response.ok().entity(authService.saveGoogleUser(token)).build();
    }

    @Path("/register")
    @GET
    @Produces(MediaType.TEXT_HTML)
    public Viewable register() {
        return new Viewable("/frontend/auth/register");
    }

    @Path("/register")
    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    public Response registerAction(@Valid RegisterReqDTO registerReqDTO) {
        return Response.ok().entity(authService.saveUser(registerReqDTO)).build();
    }

    @Path("/forgot-password")
    @GET
    @Produces(MediaType.TEXT_HTML)
    public Viewable forgotPassword() {
        return new Viewable("/frontend/auth/forgot-password");
    }

    @Path("/forgot-password")
    @POST
    @Produces(MediaType.TEXT_HTML)
    public Response forgotPasswordAction(@FormParam("email") String email) {
        return Response.ok().entity(authService.forgotPassword(email)).build();
    }

    @Path("/reset-password")
    @GET
    @Produces(MediaType.TEXT_HTML)
    public Viewable resetPassword(@QueryParam("code") String code) {
        return new Viewable("/frontend/auth/reset-password", code);
    }

    @Path("/reset-password")
    @POST
    public Response resetPasswordAction(@Valid RPReqDTO rpReqDTO) {
        return Response.ok().entity(authService.resetPassword(rpReqDTO)).build();
    }

    @Path("/verify-email")
    @GET
    public Response verifyEmail(@QueryParam("code") String code) {
        return Response.ok().entity(authService.verifyEmail(code)).build();
    }

    @Path("/update-password")
    @POST
    public Response updatePassword(@Valid UpdatePasswordDTO updatePasswordDTO) {
        return Response.ok().entity(authService.updatePassword(updatePasswordDTO)).build();
    }

    @Path("/logout")
    @GET
    public Response logout() {
        return Response.ok().entity(authService.logout()).build();
    }

    @Path("/refresh-token")
    @POST
    @Produces(MediaType.APPLICATION_JSON)
    public Response refresh(@FormParam("refreshToken") String refreshToken) {
        return Response.ok().entity(authService.refreshToken(refreshToken)).build();
    }

}
