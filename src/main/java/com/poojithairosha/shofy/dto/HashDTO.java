package com.poojithairosha.shofy.dto;

public class HashDTO {
    private String merchantID;
    private String orderID;
    private String amount;
    private String currency;
    private String hash;

    public HashDTO() {
    }

    public HashDTO(String merchantID, String orderID, String amount, String currency, String hash) {
        this.merchantID = merchantID;
        this.orderID = orderID;
        this.amount = amount;
        this.currency = currency;
        this.hash = hash;
    }

    public String getMerchantID() {
        return merchantID;
    }

    public void setMerchantID(String merchantID) {
        this.merchantID = merchantID;
    }

    public String getOrderID() {
        return orderID;
    }

    public void setOrderID(String orderID) {
        this.orderID = orderID;
    }

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }

    public String getCurrency() {
        return currency;
    }

    public void setCurrency(String currency) {
        this.currency = currency;
    }

    public String getHash() {
        return hash;
    }

    public void setHash(String hash) {
        this.hash = hash;
    }
}
