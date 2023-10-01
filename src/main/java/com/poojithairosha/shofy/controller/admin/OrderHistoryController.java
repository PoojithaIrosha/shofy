package com.poojithairosha.shofy.controller.admin;

import com.poojithairosha.shofy.annotation.IsAdmin;
import com.poojithairosha.shofy.exception.CustomException;
import com.poojithairosha.shofy.model.order.Order;
import com.poojithairosha.shofy.service.OrderService;
import jakarta.inject.Inject;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.Response;
import org.glassfish.jersey.server.mvc.Viewable;

@Path("/admin/order-history")
@IsAdmin
public class OrderHistoryController {

    @Inject
    private OrderService orderService;

    @GET
    public Viewable index(@DefaultValue("1") @QueryParam("page") Integer page) {
        return new Viewable("/backend/order-history", orderService.getOrdersPagination(page));
    }

    @GET
    @Path("/invoice/{orderId}")
    public Viewable checkoutSuccess(@PathParam("orderId") String orderId) {
        Order order = orderService.getOrderByOrderId(orderId);

        if(order == null) {
            throw new CustomException(Response.Status.NOT_FOUND, "Order not found");
        }

        return new Viewable("/backend/invoice", order);
    }


}
