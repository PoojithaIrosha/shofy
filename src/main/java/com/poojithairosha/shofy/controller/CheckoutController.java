package com.poojithairosha.shofy.controller;

import com.poojithairosha.shofy.annotation.IsUser;
import com.poojithairosha.shofy.dto.CheckoutReqDTO;
import com.poojithairosha.shofy.dto.HashDTO;
import com.poojithairosha.shofy.model.cart.Cart;
import com.poojithairosha.shofy.service.CartService;
import com.poojithairosha.shofy.service.CheckoutService;
import jakarta.inject.Inject;
import jakarta.validation.Valid;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import org.glassfish.jersey.server.mvc.Viewable;

import java.util.HashMap;

@Path("/user/checkout")
@IsUser
public class CheckoutController {

    @Inject
    private CheckoutService checkoutService;

    @GET
    public Viewable checkout() {
        try {
            HashMap<String, Object> checkout = checkoutService.getCheckout();
            return new Viewable("/frontend/checkout", checkout);
        } catch (Exception e) {
            return new Viewable("/frontend/cart");
        }
    }

    @GET
    @Path("/hash")
    public HashDTO getHash(@QueryParam("amount") double amount) {
        return checkoutService.getHash(amount);
    }

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    public void order(@Valid CheckoutReqDTO checkoutReqDTO) {
        checkoutService.checkout(checkoutReqDTO);
    }

}
