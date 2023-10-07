package com.poojithairosha.shofy.dto;

import java.io.Serializable;

public class TestDTO implements Serializable {
    private String type;
    private Integer number;

    public TestDTO(String type, Integer number) {
        this.type = type;
        this.number = number;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Integer getNumber() {
        return number;
    }

    public void setNumber(Integer number) {
        this.number = number;
    }
}
