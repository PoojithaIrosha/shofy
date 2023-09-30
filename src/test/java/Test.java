import com.poojithairosha.shofy.util.ImageURIUtil;
import io.fusionauth.jwks.JSONWebKeySetHelper;
import io.fusionauth.jwks.domain.JSONWebKey;

import java.security.PublicKey;
import java.util.List;

public class Test {

    public static void main(String[] args) {
//        List<JSONWebKey> keys = JSONWebKeySetHelper.retrieveKeysFromJWKS("https://www.googleapis.com/oauth2/v3/certs");

        System.out.println(ImageURIUtil.convertFileToDataURI("/Users/poojithairosha/shofy/profileimages/priyani@gmail.com.jpg"));
//
//        PublicKey publicKey = JSONWebKey.parse(keys.get(1));
    }
}
