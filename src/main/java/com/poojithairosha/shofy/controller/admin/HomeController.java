package com.poojithairosha.shofy.controller.admin;

import com.poojithairosha.shofy.annotation.IsAdmin;
import com.poojithairosha.shofy.service.admin.AdminHomeService;
import jakarta.inject.Inject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.Response;
import org.glassfish.jersey.server.mvc.Viewable;

import java.net.URI;
import java.util.Map;

@Path("/admin")
@IsAdmin
public class HomeController {

    @Context
    private HttpServletRequest request;

    @Inject
    private AdminHomeService service;

    @GET
    public Response index() {
        String contextPath = request.getContextPath();
        return Response.seeOther(URI.create(contextPath + "/admin/dashboard")).build();
    }

    @GET
    @Path("/dashboard")
    public Viewable home() {
        Map<String, Object> dashboard = service.getDashboard();
        return new Viewable("/backend/home", dashboard);
    }

}
