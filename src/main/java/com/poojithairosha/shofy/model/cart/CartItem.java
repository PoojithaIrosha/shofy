package com.poojithairosha.shofy.model.cart;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.poojithairosha.shofy.model.product.Product;
import com.poojithairosha.shofy.model.product.ProductColors;
import jakarta.persistence.*;

import java.io.Serializable;

@Entity
@Table(name = "cart_item")
public class CartItem implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "product_id", referencedColumnName = "id")
    private Product product;

    private Integer quantity;

    @ManyToOne
    @JoinColumn(name = "color_id", referencedColumnName = "id")
    private ProductColors color;

    @JsonIgnore
    @ManyToOne
    @JoinColumn(name = "cart_id", referencedColumnName = "id")
    private Cart cart;

    public CartItem() {
    }

    public CartItem(Product product, Integer quantity, ProductColors color, Cart cart) {
        this.product = product;
        this.quantity = quantity;
        this.color = color;
        this.cart = cart;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public Cart getCart() {
        return cart;
    }

    public void setCart(Cart cart) {
        this.cart = cart;
    }

    public ProductColors getColor() {
        return color;
    }

    public void setColor(ProductColors color) {
        this.color = color;
    }
}
