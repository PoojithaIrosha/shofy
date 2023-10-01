package com.poojithairosha.shofy;

import com.poojithairosha.shofy.listener.ContextListener;
import org.apache.catalina.Context;
import org.apache.catalina.LifecycleException;
import org.apache.catalina.startup.Tomcat;

import java.io.File;

public class Main {
    public static void main(String[] args) {
        Tomcat tomcat = new Tomcat();
        tomcat.setPort(8080);
        tomcat.getConnector();

        Context context = tomcat.addWebapp("/shofy", new File("./src/main/webapp").getAbsolutePath());
        context.setAllowCasualMultipartParsing(true);
        context.addApplicationListener(ContextListener.class.getName());

//        WebResourceRoot root = new StandardRoot(context);
//        String path = new File("./target/classes").getAbsolutePath();
//        root.addPreResources(new DirResourceSet(root,"/WEB-INF/classes",path,"/"));
//        context.setResources(root);

        try {
            tomcat.start();
            tomcat.getServer().await();
        } catch (LifecycleException ex) {
            throw new RuntimeException(ex);
        }

    }
}
