package com.poojithairosha.shofy.controller;

import com.poojithairosha.shofy.annotation.IsUser;
import com.poojithairosha.shofy.dto.UpdateProfileDTO;
import com.poojithairosha.shofy.model.user.User;
import com.poojithairosha.shofy.service.UserService;
import jakarta.inject.Inject;
import jakarta.validation.Valid;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.PUT;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import org.glassfish.jersey.server.mvc.Viewable;

@Path("/user/profile")
@IsUser
public class UserProfileController {

    @Inject
    private UserService userService;

    @GET
    public Response getUserProfile() {
        User user = userService.getUserFromSession();
        if (user != null) {
            return Response.ok().entity(new Viewable("/frontend/user-profile", user)).build();
        } else {
            return Response.status(Response.Status.UNAUTHORIZED).entity(new Viewable("/frontend/login")).build();
        }
    }

    @Path("/update")
    @PUT
    @Consumes(MediaType.APPLICATION_JSON)
    public Response updateProfile(@Valid UpdateProfileDTO dto) {
        String result = userService.updateUser(dto);
        if(result.equals("success")) {
            return Response.ok().entity("User profile updated successfully").build();
        }else {
            return Response.status(Response.Status.BAD_REQUEST).entity(result).build();
        }
    }

}
