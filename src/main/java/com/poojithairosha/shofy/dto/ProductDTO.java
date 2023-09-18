package com.poojithairosha.shofy.dto;

import com.poojithairosha.shofy.model.product.ProductBrand;
import com.poojithairosha.shofy.model.product.ProductCategory;
import com.poojithairosha.shofy.model.product.ProductColors;
import com.poojithairosha.shofy.model.product.ProductImages;
import jakarta.persistence.*;

import java.util.List;

public class ProductDTO {

    private Long id;

    private String name;

    private String description;

    private Double price;

    private Integer quantity;

    private ProductBrand brand;

    private ProductCategory category;

    private List<ProductColors> colors;

    private List<ProductImages> images;

    public ProductDTO() {
    }

    public ProductDTO(Long id, String name, String description, Double price, Integer quantity, ProductBrand brand, ProductCategory category, List<ProductColors> colors, List<ProductImages> images) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.quantity = quantity;
        this.brand = brand;
        this.category = category;
        this.colors = colors;
        this.images = images;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public ProductBrand getBrand() {
        return brand;
    }

    public void setBrand(ProductBrand brand) {
        this.brand = brand;
    }

    public ProductCategory getCategory() {
        return category;
    }

    public void setCategory(ProductCategory category) {
        this.category = category;
    }

    public List<ProductColors> getColors() {
        return colors;
    }

    public void setColors(List<ProductColors> colors) {
        this.colors = colors;
    }

    public List<ProductImages> getImages() {
        return images;
    }

    public void setImages(List<ProductImages> images) {
        this.images = images;
    }
}
