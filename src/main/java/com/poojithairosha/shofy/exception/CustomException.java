package com.poojithairosha.shofy.exception;

import jakarta.ws.rs.core.Response;

public class CustomException extends RuntimeException {

    private Response.Status status;

    public CustomException(Response.Status status, String message) {
        super(message);
        this.status = status;
    }

    public Response.Status getStatus() {
        return status;
    }
}
