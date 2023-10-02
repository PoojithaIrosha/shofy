package com.poojithairosha.shofy.controller;

import com.poojithairosha.shofy.model.product.Product;
import com.poojithairosha.shofy.service.ProductService;
import jakarta.inject.Inject;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import org.glassfish.jersey.server.mvc.Viewable;

import java.util.HashMap;
import java.util.Map;


@Path("/products")
public class ProductController {

    @Inject
    ProductService productService;

    @GET
    public Viewable getProducts(@DefaultValue("1") @QueryParam("page") Integer page, @DefaultValue("all") @QueryParam("search") String search, @DefaultValue("0") @QueryParam("category") Long categoryId, @DefaultValue("0") @QueryParam("price-min") Long minPrice, @DefaultValue("0") @QueryParam("price-max") Long maxPrice) {
        try {
            Map<String, Object> productsPagination = productService.getProductsPagination(page, search, categoryId, minPrice, maxPrice);
            return new Viewable("/frontend/products", productsPagination);
        }catch (Exception e) {
            return new Viewable("/frontend/products", null);
        }
    }

    @GET
    @Path("/{id}")
    public Viewable getProduct(@PathParam("id") Long id) {
        Map<String, Object> productView = productService.getProductView(id);
        return new Viewable("/frontend/product-details", productView);
    }

    @GET
    @Path("/get/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getProductObj(@PathParam("id") Long id) {
        return Response.ok().entity(productService.getActiveProductById(id)).build();
    }

    @GET
    @Path("/get/qty/{id}")
    public Response getProductQty(@PathParam("id") Long id) {
        return Response.ok().entity(productService.getProductQty(id)).build();
    }

}
