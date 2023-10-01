package com.poojithairosha.shofy.controller.admin;

import com.poojithairosha.shofy.dto.LoginRespDTO;
import com.poojithairosha.shofy.service.admin.AdminAuthService;
import jakarta.inject.Inject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import org.glassfish.jersey.media.multipart.FormDataParam;
import org.glassfish.jersey.server.mvc.Viewable;

import java.net.URI;

@Path("/admin")
public class AuthController {

    @Inject
    private AdminAuthService authService;

    @Context
    private HttpServletRequest request;

    @GET
    @Path("/login")
    public Viewable adminLogin() {
        return new Viewable("/backend/auth/login");
    }

    @POST
    @Path("/login")
    @Produces(MediaType.APPLICATION_JSON)
    public Response adminLoginAction(@FormParam("email") String email, @FormParam("password") String password) {
        return Response.ok().entity(authService.login(email, password)).build();
    }

    @Path("/logout")
    @GET
    public Response logout() {
        if (authService.logout().equals("success")) {
            return Response.seeOther(URI.create(request.getContextPath() + "/admin/login")).build();
        }else {
            return Response.seeOther(URI.create(request.getContextPath() + "/admin/dashboard")).build();
        }
    }

}
