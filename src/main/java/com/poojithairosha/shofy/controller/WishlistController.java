package com.poojithairosha.shofy.controller;

import com.poojithairosha.shofy.annotation.IsUser;
import com.poojithairosha.shofy.model.wishlist.Wishlist;
import com.poojithairosha.shofy.service.WishlistService;
import jakarta.inject.Inject;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import org.glassfish.jersey.server.mvc.Viewable;

@Path("/user/wishlist")
@IsUser
public class WishlistController {

    @Inject
    private WishlistService wishlistService;

    @GET
    @Produces(MediaType.TEXT_HTML)
    public Viewable wishlist() {
        Wishlist wishlist = wishlistService.getWishlist();
        return new Viewable("/frontend/wishlist", wishlist);
    }

    @POST
    @Path("/add")
    public Response addProduct(@FormParam("product_id") Long productId) {
        return Response.ok().entity(wishlistService.addProduct(productId)).build();
    }

    @DELETE
    @Path("/remove/{wishlistId}/{wishlistItemId}")
    public Response deleteCartItem(@PathParam("wishlistId") Long wishlistId, @PathParam("wishlistItemId") Long wishlistItemId) {
        return Response.ok().entity(wishlistService.deleteWishlistItem(wishlistId, wishlistItemId)).build();
    }

}
