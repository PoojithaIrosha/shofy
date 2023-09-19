package com.poojithairosha.shofy.controller;

import com.poojithairosha.shofy.model.product.Product;
import com.poojithairosha.shofy.service.ProductService;
import jakarta.inject.Inject;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;
import org.glassfish.jersey.server.mvc.Viewable;

import java.util.List;

@Path("/")
public class HomeController {

    @Inject
    ProductService productService;

    @GET
    @Produces(MediaType.TEXT_HTML)
    public Viewable index() {
        List<Product> products = productService.getProducts();
        return new Viewable("/frontend/home", products);
    }

    @GET
    @Path("/contact")
    @Produces(MediaType.TEXT_HTML)
    public Viewable contact() {
        return new Viewable("/frontend/contact");
    }

}
