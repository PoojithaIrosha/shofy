package com.poojithairosha.shofy.controller.admin;

import com.poojithairosha.shofy.annotation.IsAdmin;
import com.poojithairosha.shofy.service.UserService;
import jakarta.inject.Inject;
import jakarta.ws.rs.*;
import org.glassfish.jersey.server.mvc.Viewable;

@Path("/admin/users")
@IsAdmin
public class UserController {

    @Inject
    private UserService userService;

    @GET
    public Viewable index(@DefaultValue("1") @QueryParam("page") Integer page, @DefaultValue("all") @QueryParam("search") String search) {
        return new Viewable("/backend/all-users", userService.getUsersPagination(page, search));
    }

    @PATCH
    @Path("/update-status")
    public String changeUserStatus(@FormParam("userId") Long userId) {
        return userService.updateUserStatus(userId);
    }

}
