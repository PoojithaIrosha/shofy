package com.poojithairosha.shofy.model.order;

import jakarta.persistence.*;

import java.io.Serializable;

@Entity
@Table(name = "delivery_fee")
public class DeliveryFee implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String city;

    private Double fee;

    public DeliveryFee() {
    }

    public DeliveryFee(String city, double fee) {
        this.city = city;
        this.fee = fee;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public double getFee() {
        return fee;
    }

    public void setFee(double fee) {
        this.fee = fee;
    }
}
