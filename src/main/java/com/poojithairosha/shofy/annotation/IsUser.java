package com.poojithairosha.shofy.annotation;

import jakarta.annotation.Priority;
import jakarta.ws.rs.NameBinding;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

@Retention(RetentionPolicy.RUNTIME)
@NameBinding
public @interface IsUser {

}
