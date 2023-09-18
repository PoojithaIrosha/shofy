package com.poojithairosha.shofy.dto;

import jakarta.validation.constraints.NotEmpty;

import java.io.Serializable;

public class RPReqDTO implements Serializable {
    @NotEmpty(message = "Code cannot be empty")
    private String code;

    @NotEmpty(message = "Password cannot be empty")
    private String password;

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
