package com.poojithairosha.shofy.exception;

import jakarta.validation.ConstraintViolation;
import jakarta.validation.ConstraintViolationException;
import jakarta.ws.rs.core.Response;
import jakarta.ws.rs.ext.ExceptionMapper;
import jakarta.ws.rs.ext.Provider;

@Provider
public class ConstraintViolationExceptionMapper implements ExceptionMapper<ConstraintViolationException> {

    @Override
    public Response toResponse(ConstraintViolationException e) {
        return Response.status(Response.Status.BAD_REQUEST)
                .entity(prepareMessage(e))
                .type("text/plain")
                .build();
    }

    private String prepareMessage(ConstraintViolationException exception) {
        StringBuilder message = new StringBuilder();
        for (ConstraintViolation<?> cv : exception.getConstraintViolations()) {
            message.append(cv.getMessage() + ",");
        }
        return message.toString();
    }
}
