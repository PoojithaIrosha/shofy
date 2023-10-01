package com.poojithairosha.shofy.controller.admin;

import com.poojithairosha.shofy.annotation.IsAdmin;
import com.poojithairosha.shofy.model.product.Product;
import com.poojithairosha.shofy.service.ProductService;
import jakarta.inject.Inject;
import jakarta.validation.constraints.NotNull;
import jakarta.ws.rs.*;
import org.glassfish.jersey.media.multipart.FormDataBodyPart;
import org.glassfish.jersey.media.multipart.FormDataParam;
import org.glassfish.jersey.server.mvc.Viewable;

@Path("/admin/products")
@IsAdmin
public class ProductController {

    @Inject
    ProductService productService;

    @GET
    public Viewable index(@DefaultValue("1") @QueryParam("page") Integer page, @DefaultValue("all") @QueryParam("search") String search, @DefaultValue("0") @QueryParam("category") Long categoryId, @DefaultValue("0") @QueryParam("price-min") Long minPrice, @DefaultValue("0") @QueryParam("price-max") Long maxPrice) {
        return new Viewable("/backend/all-products", productService.getAllProductsPagination(page, search, categoryId, minPrice, maxPrice));
    }

    @GET
    @Path("/add")
    public Viewable add() {
        return new Viewable("/backend/add-product");
    }


    @GET
    @Path("/edit/{id}")
    public Viewable edit(@PathParam("id") Long id) {
        Product productById = productService.getProductById(id);
        if (productById != null) {
            return new Viewable("/backend/edit-product", productById);
        } else {
            return new Viewable("/backend/404");
        }
    }

    @POST
    @Path("/add")
    public String addAction(@NotNull @FormParam("name") String name, @FormParam("description") String description, @FormParam("price") Double price, @FormParam("quantity") Integer quantity, @FormParam("brand") String brand, @FormParam("category") String category, @FormDataParam("images") FormDataBodyPart formDataBodyPart) {
        return productService.addProduct(name, description, price, quantity, brand, category, formDataBodyPart);
    }

    @PUT
    @Path("/edit/{id}")
    public String editAction(@PathParam("id") Long id, @FormParam("name") String name, @FormParam("description") String description, @FormParam("price") Double price, @FormParam("quantity") Integer quantity, @FormParam("brand") String brand, @FormParam("category") String category, @FormDataParam("images") FormDataBodyPart formDataBodyPart, @FormParam("active") boolean active) {
        return productService.editProduct(id, name, description, price, quantity, brand, category, formDataBodyPart, active);
    }

}
