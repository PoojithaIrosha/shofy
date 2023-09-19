package com.poojithairosha.shofy.model.wishlist;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.poojithairosha.shofy.model.cart.Cart;
import com.poojithairosha.shofy.model.product.Product;
import jakarta.persistence.*;

@Entity
@Table(name = "wishlist_item")
public class WishlistItem {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "product_id", referencedColumnName = "id")
    private Product product;

    @JsonIgnore
    @ManyToOne
    @JoinColumn(name = "wishlist_id", referencedColumnName = "id")
    private Wishlist wishlist;

    public WishlistItem() {
    }

    public WishlistItem(Product product, Wishlist wishlist) {
        this.product = product;
        this.wishlist = wishlist;
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

    public Wishlist getWishlist() {
        return wishlist;
    }

    public void setWishlist(Wishlist wishlist) {
        this.wishlist = wishlist;
    }
}
