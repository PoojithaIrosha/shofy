package com.poojithairosha.shofy.util;

import com.poojithairosha.shofy.model.user.User;
import io.fusionauth.jwt.JWTExpiredException;
import io.fusionauth.jwt.Signer;
import io.fusionauth.jwt.Verifier;
import io.fusionauth.jwt.domain.JWT;
import io.fusionauth.jwt.hmac.HMACSigner;
import io.fusionauth.jwt.hmac.HMACVerifier;

import java.time.ZoneOffset;
import java.time.ZonedDateTime;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

public class JwtTokenUtil {
    private static final String CLAIM_KEY_USERNAME = "sub";
    private static final String CLAIM_KEY_CREATED = "created";
    private static final String ISSUER = "www.shofy.com";
    private static final String SECRET = ",4zaB?V{ev@J%ALj]Y%+0V4h[-XxZL[&+=qK)aNC+Z1kr57R,UiCd,ZHp9FD(]TQ";
    private static final Long EXPIRATION_MINUTES = 1L; // TODO: change this to 30L
    private static final Long REFRESH_TOKEN_EXPIRATION_MINUTES = 43200L;

    private String generateToken(String subject, Map<String, String> claims, Long expiration) {
        // Build an HMAC signer using a SHA-256 hash
        Signer signer = HMACSigner.newSHA256Signer(SECRET);

        // Build a new JWT with an issuer(iss), issued at(iat), subject(sub) and expiration(exp)
        JWT jwt = new JWT().setIssuer(ISSUER)
                .setIssuedAt(ZonedDateTime.now(ZoneOffset.UTC))
                .setSubject(subject)
                .setExpiration(ZonedDateTime.now(ZoneOffset.UTC).plusMinutes(expiration));

        claims.keySet().forEach(key -> {
            if (claims.get(key) != null) {
                jwt.addClaim(key, claims.get(key));
            }
        });

        return JWT.getEncoder().encode(jwt, signer);
    }

    public Map<String, String> getClaims(String token) {
        // Build an HMAC signer using a SHA-256 hash
        Verifier verifier = HMACVerifier.newVerifier(SECRET);

        // Verify and decode the encoded string JWT to a rich object
        JWT jwt = JWT.getDecoder().decode(token, verifier);

        Map<String, String> claims = new HashMap<>();

        if (jwt != null) {
            jwt.getAllClaims().forEach((key, value) -> {
                claims.put(key, value.toString());
            });
        }

        return claims;
    }

    public String getUsername(String token) {
        Map<String, String> claims = getClaims(token);
        return claims.get(CLAIM_KEY_USERNAME);
    }

    public Date getExpireDate(String token) {
        Verifier verifier = HMACVerifier.newVerifier(SECRET);
        JWT jwt = JWT.getDecoder().decode(token, verifier);

        return new Date(jwt.expiration.toInstant().toEpochMilli());
    }

    public boolean isTokenExpired(String token) {
        Date expDate = getExpireDate(token);
        return expDate.before(new Date(System.currentTimeMillis()));
    }

    public boolean validateToken(String token, User userDetails) {
        try {
            String username = getUsername(token);
            return (username.equals(userDetails.getEmail()) && !isTokenExpired(token));
        }catch (JWTExpiredException ex) {
            return false;
        }
    }

    public String generateAccessToken(User user) {
        Map<String, String> claims = new HashMap<>();
        claims.put(CLAIM_KEY_USERNAME, user.getEmail());
        claims.put(CLAIM_KEY_CREATED, new Date().toString());
        claims.put("user_type", user.getUserType().toString());

        return generateToken(user.getEmail(), claims, EXPIRATION_MINUTES);
    }

    public String generateRefreshToken(User user) {
        Map<String, String> claims = new HashMap<>();
        claims.put(CLAIM_KEY_USERNAME, user.getEmail());
        claims.put(CLAIM_KEY_CREATED, new Date().toString());
        claims.put("user_type", user.getUserType().toString());

        return generateToken(user.getEmail(), claims, REFRESH_TOKEN_EXPIRATION_MINUTES);
    }
}
