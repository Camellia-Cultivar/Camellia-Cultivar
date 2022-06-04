package com.camellia;

// Code from Yiğit Kemal Erinç
// https://www.freecodecamp.org/news/how-to-setup-jwt-authorization-and-authentication-in-spring/
// 
// Adapted by: Vítor Dias

public class SecurityConstants {

    public static final String SECRET = "MYSTERY_KEY";
    public static final long EXPIRATION_TIME = 900_000; // 15 mins
    public static final String TOKEN_PREFIX = "Bearer ";
    public static final String HEADER_STRING = "Authorization";
    public static final String SIGN_UP_URL = "/api/users/signup";
    public static final String LOGIN_URL = "/api/users/login";
}
