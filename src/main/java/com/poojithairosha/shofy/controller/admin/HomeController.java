package com.poojithairosha.shofy.controller.admin;

import com.poojithairosha.shofy.annotation.IsAdmin;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.Response;
import org.glassfish.jersey.server.mvc.Viewable;

import java.net.URI;

@Path("/admin")
@IsAdmin
public class HomeController {

    @Context
    private HttpServletRequest request;

    @GET
    public Response index() {
        String contextPath = request.getContextPath();
        return Response.seeOther(URI.create(contextPath + "/admin/dashboard")).build();
    }

    @GET
    @Path("/dashboard")
    public Viewable home() {
        return new Viewable("/backend/home");
    }

}
