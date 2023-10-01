package com.poojithairosha.shofy.controller;

import com.poojithairosha.shofy.annotation.IsUser;
import com.poojithairosha.shofy.dto.UpdateProfileDTO;
import com.poojithairosha.shofy.model.order.Order;
import com.poojithairosha.shofy.model.user.User;
import com.poojithairosha.shofy.service.FileUploadService;
import com.poojithairosha.shofy.service.OrderService;
import com.poojithairosha.shofy.service.UserService;
import com.poojithairosha.shofy.util.ImageURIUtil;
import jakarta.inject.Inject;
import jakarta.validation.Valid;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import org.glassfish.jersey.media.multipart.FormDataContentDisposition;
import org.glassfish.jersey.media.multipart.FormDataParam;
import org.glassfish.jersey.server.mvc.Viewable;

import java.io.*;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

@Path("/user/profile")
@IsUser
public class UserProfileController {

    @Inject
    private UserService userService;

    @Inject
    private OrderService orderService;

    @GET
    public Response getUserProfile() {
        User user = userService.getUserFromSession();
        List<Order> orders = orderService.getOrders(user);

        HashMap<String, Object> data = new HashMap<>();
        data.put("user", user);
        data.put("orders", orders);

        if (user != null) {
            return Response.ok().entity(new Viewable("/frontend/user-profile", data)).build();
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

    @PUT
    @Path("/update-picture")
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    @Produces(MediaType.APPLICATION_JSON)
    public Response updatePicture(@FormDataParam("file") InputStream fileInputStream, @FormDataParam("file") FormDataContentDisposition fileMetaData) {
        return Response.ok().entity(userService.updateProfilePicture(fileInputStream, fileMetaData)).build();
    }

}
