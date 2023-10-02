package com.poojithairosha.shofy.config;

import com.poojithairosha.shofy.controller.WishlistController;
import com.poojithairosha.shofy.service.*;
import com.poojithairosha.shofy.service.admin.AdminAuthService;
import com.poojithairosha.shofy.service.admin.AdminHomeService;
import com.poojithairosha.shofy.util.JwtTokenUtil;
import jakarta.inject.Singleton;
import org.glassfish.hk2.utilities.binding.AbstractBinder;

public class DependencyBinder extends AbstractBinder {

    @Override
    protected void configure() {
        bind(AuthService.class).to(AuthService.class).in(Singleton.class);
        bind(JwtTokenUtil.class).to(JwtTokenUtil.class).in(Singleton.class);
        bind(UserService.class).to(UserService.class).in(Singleton.class);
        bind(ProductService.class).to(ProductService.class).in(Singleton.class);
        bind(CartService.class).to(CartService.class).in(Singleton.class);
        bind(CheckoutService.class).to(CheckoutService.class).in(Singleton.class);
        bind(OrderService.class).to(OrderService.class).in(Singleton.class);
        bind(FileUploadService.class).to(FileUploadService.class).in(Singleton.class);
        bind(WishlistService.class).to(WishlistService.class).in(Singleton.class);
        bind(AdminAuthService.class).to(AdminAuthService.class).in(Singleton.class);
        bind(AdminHomeService.class).to(AdminHomeService.class).in(Singleton.class);
    }
}
