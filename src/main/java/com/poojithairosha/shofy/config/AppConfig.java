package com.poojithairosha.shofy.config;

import org.glassfish.jersey.server.ResourceConfig;
import org.glassfish.jersey.server.ServerProperties;
import org.glassfish.jersey.server.mvc.jsp.JspMvcFeature;

public class AppConfig extends ResourceConfig {

    public AppConfig() {
        packages("com.poojithairosha.shofy.controller");
        packages("com.poojithairosha.shofy.middleware");
        packages("com.poojithairosha.shofy.exception");
        register(JspMvcFeature.class);
        register(DependencyBinder.class);
        property(JspMvcFeature.TEMPLATE_BASE_PATH, "/WEB-INF/views");
        property(ServerProperties.BV_SEND_ERROR_IN_RESPONSE, true);
    }

}
