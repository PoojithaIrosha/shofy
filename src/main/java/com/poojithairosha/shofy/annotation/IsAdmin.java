package com.poojithairosha.shofy.annotation;

import jakarta.ws.rs.NameBinding;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

@Retention(RetentionPolicy.RUNTIME)
@NameBinding
public @interface IsAdmin {
}
