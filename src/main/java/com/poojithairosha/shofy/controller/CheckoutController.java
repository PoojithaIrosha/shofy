package com.poojithairosha.shofy.controller;

import com.poojithairosha.shofy.annotation.IsUser;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import org.glassfish.jersey.server.mvc.Viewable;

@Path("/user/checkout")
@IsUser
public class CheckoutController {

    @GET
    public Viewable checkout() {
        return new Viewable("/frontend/checkout");
    }



}
