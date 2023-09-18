package com.poojithairosha.shofy.controller;

import com.poojithairosha.shofy.annotation.IsUser;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import org.glassfish.jersey.server.mvc.Viewable;

@Path("/user/wishlist")
@IsUser
public class WishlistController {

    @GET
    public Viewable wishlist() {
        return new Viewable("/frontend/wishlist");
    }

}
