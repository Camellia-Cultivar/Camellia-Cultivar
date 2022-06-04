package com.camellia;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.FilterChain;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.camellia.models.users.User;
import com.camellia.repositories.users.UserRepository;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;


public class JWTAuthenticationFilter extends UsernamePasswordAuthenticationFilter{
    
    private AuthenticationManager authManager;

    @Autowired
    private UserRepository userRepository;

    public JWTAuthenticationFilter(AuthenticationManager authManager, ApplicationContext context) {
        this.authManager = authManager;
        this.userRepository= context.getBean(UserRepository.class);

        setFilterProcessesUrl(SecurityConstants.LOGIN_URL); 
    }

    @Override
    public Authentication attemptAuthentication(HttpServletRequest request,
                                                HttpServletResponse response) throws AuthenticationException{

        
        try {
            User creds = new ObjectMapper().readValue(request.getInputStream(), User.class);

            return authManager.authenticate(
                    new UsernamePasswordAuthenticationToken(creds.getEmail(), creds.getPassword(), new ArrayList<>())
            );
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    protected void successfulAuthentication(HttpServletRequest request,
                                            HttpServletResponse response,
                                            FilterChain chain,
                                            Authentication auth) throws IOException {
        String token = JWT.create()
                .withSubject(((org.springframework.security.core.userdetails.User) auth.getPrincipal()).getUsername())
                .withExpiresAt(new Date(System.currentTimeMillis() + SecurityConstants.EXPIRATION_TIME))
                .sign(Algorithm.HMAC512(SecurityConstants.SECRET.getBytes()));

        String email = ((org.springframework.security.core.userdetails.User) auth.getPrincipal()).getUsername();                               
        long userId = userRepository.findByEmail(email).getUserId();
        String body = userId + " " + token;

        response.getWriter().write(body);
        response.getWriter().flush();
    }
}
