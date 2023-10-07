package com.poojithairosha.shofy.controller;

import com.poojithairosha.shofy.dto.TestDTO;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import org.glassfish.jersey.server.mvc.Viewable;

@Path("/test")
public class TestController {

    @GET
    public Viewable index() {
        return new Viewable("/frontend/test");
    }

    @POST
    @Produces(MediaType.APPLICATION_JSON)
    public TestDTO indexPost(@FormParam("number") Integer number) {
        if(number % 2 == 0) {
            return new TestDTO("EVEN", number);
        }else {
            return new TestDTO("ODD", number);
        }
    }
}
