package com.poojithairosha.shofy.controller;

import com.poojithairosha.shofy.annotation.IsUser;
import com.poojithairosha.shofy.model.cart.Cart;
import com.poojithairosha.shofy.service.CartService;
import jakarta.inject.Inject;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import org.glassfish.jersey.server.mvc.Viewable;

@Path("/user/cart")
@IsUser
public class CartController {

    @Inject
    CartService cartService;

    @GET
    public Viewable cart() {
        Cart cart = cartService.getCart();

        if (cart != null) {
            return new Viewable("/frontend/cart", cart);
        }else {
            return new Viewable("/frontend/cart", null);
        }

    }

    @GET
    @Path("/get")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getCart() {
        Cart cart = cartService.getCart();
        return Response.ok().entity(cart).build();
    }

    @POST
    @Path("/add")
    public Response addProduct(@FormParam("product_id") Long productId, @FormParam("quantity") Integer quantity, @FormParam("color-id") Long colorId) {
        String result = cartService.addProduct(productId, quantity, colorId);
        return Response.ok().entity(result).build();
    }

    @DELETE
    @Path("/remove/{cartId}/{cartItemId}")
    public Response deleteCartItem(@PathParam("cartId") Long cartId, @PathParam("cartItemId") Long cartItemId) {
        return Response.ok().entity(cartService.deleteCartItem(cartId, cartItemId)).build();
    }

    @PUT
    @Path("/update-qty")
    public Response updateQty(@FormParam("id") Long id, @FormParam("qty") Integer qty) {
        return Response.ok(cartService.updateQty(id, qty)).build();
    }

}
