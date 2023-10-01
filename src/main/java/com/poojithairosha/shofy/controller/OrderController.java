package com.poojithairosha.shofy.controller;

import com.poojithairosha.shofy.annotation.IsUser;
import com.poojithairosha.shofy.exception.CustomException;
import com.poojithairosha.shofy.model.order.Order;
import com.poojithairosha.shofy.service.OrderService;
import jakarta.inject.Inject;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.core.Response;
import org.glassfish.jersey.server.mvc.Viewable;

@Path("/user/order")
@IsUser
public class OrderController {

    @Inject
    private OrderService orderService;

    @GET
    @Path("/success/{orderId}")
    public Viewable checkoutSuccess(@PathParam("orderId") String orderId) {
        Order order = orderService.getOrderByOrderId(orderId);

        if(order == null) {
            throw new CustomException(Response.Status.NOT_FOUND, "Order not found");
        }

        return new Viewable("/frontend/order-success", order);
    }

}
