package com.poojithairosha.shofy.util;

import com.poojithairosha.shofy.exception.CustomException;
import jakarta.ws.rs.core.Response;

import java.math.BigInteger;
import java.security.MessageDigest;

public class Encryption {

    public static String encrypt(String password) {
        String md5 = "";
        try {
            MessageDigest digest = MessageDigest.getInstance("MD5");
            digest.update(password.getBytes(), 0, password.length());
            md5 = new BigInteger(1, digest.digest()).toString(16);
        } catch (Exception ex) {
            throw new CustomException(Response.Status.INTERNAL_SERVER_ERROR, "Error while encrypting password");
        }
        return md5;
    }

    public static boolean verifyPassword(String inputPassword, String hashedPassword) {
        String hashedInput = encrypt(inputPassword);
        return hashedInput.equals(hashedPassword);
    }

}
