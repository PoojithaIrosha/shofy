package com.poojithairosha.shofy.controller;

import com.poojithairosha.shofy.annotation.IsUser;
import com.poojithairosha.shofy.model.product.Product;
import com.poojithairosha.shofy.service.ProductService;
import jakarta.inject.Inject;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.Response;
import org.glassfish.jersey.server.mvc.Viewable;

import javax.swing.text.View;
import java.util.List;


@Path("/products")
public class ProductController {

    @Inject
    ProductService productService;

    @GET
    public Viewable getProducts(@DefaultValue("1") @QueryParam("page") Integer page, @DefaultValue("all") @QueryParam("search") String search) {
        return new Viewable("/frontend/products", productService.getProductsPagination(page, search));
    }

    @GET
    @Path("/{id}")
    public Viewable getProduct(@PathParam("id") Long id) {
        Product product = productService.getProductById(id);
        return new Viewable("/frontend/product-details", product);
    }

    @GET
    @Path("/get/{id}")
    public Response getProductObj(@PathParam("id") Long id) {
        return Response.ok().entity(productService.getProductById(id)).build();
    }

    @GET
    @Path("/get/qty/{id}")
    public Response getProductQty(@PathParam("id") Long id) {
        return Response.ok().entity(productService.getProductQty(id)).build();
    }

}
