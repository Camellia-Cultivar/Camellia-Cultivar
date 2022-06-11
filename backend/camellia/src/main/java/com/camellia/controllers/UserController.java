package com.camellia.controllers;

import java.io.UnsupportedEncodingException;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import com.camellia.models.users.RegisteredUser;
import com.camellia.models.users.User;
import com.camellia.services.users.RegisteredUserService;
import com.camellia.services.users.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.repository.query.Param;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.MailException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/users")
public class UserController {
    @Autowired
    private UserService userService;
    @Autowired
    private RegisteredUserService registeredUserService;

    @PostMapping(value="/signup", consumes = {MediaType.APPLICATION_JSON_VALUE})
    public ResponseEntity<String> createUser(@Valid @RequestBody RegisteredUser user, HttpServletRequest request) throws MailException, UnsupportedEncodingException, MessagingException{
        return registeredUserService.addRegisteredUser(user, getSiteURL(request));
    }

    @GetMapping(value="/{id}")
    public ResponseEntity<String> getProfile(@PathVariable(value = "id") long id){
        if(checkRoleRegistered())
            return userService.getUserProfile(id);
        return ResponseEntity.status(HttpStatus.FORBIDDEN).body(null);
    }

    @PutMapping(value="/{id}", consumes = {MediaType.APPLICATION_JSON_VALUE})
    public ResponseEntity<String> editProfile(@Valid @RequestBody User tempUser, @PathVariable(value = "id") long id){
        if(checkRoleRegistered())
            return this.userService.editProfile( tempUser, id );
        return ResponseEntity.status(HttpStatus.FORBIDDEN).body(null);
    }

    @PutMapping(value="/admin/{id}")
    public ResponseEntity<String> giveAdminRole(@PathVariable(value = "id") long userId){
        if(checkAdminRole())
            return userService.giveAdminRole(userId);
        return ResponseEntity.status(HttpStatus.FORBIDDEN).body(null);
    }

    @PutMapping(value="/mod/{id}")
    public ResponseEntity<String> giveModRole(@PathVariable(value = "id") long userId){
        if(checkRole())
            return userService.giveModRole(userId);
        return ResponseEntity.status(HttpStatus.FORBIDDEN).body(null);
    }


    @GetMapping(value="/verify")
    public String verifyUser(@Param("code") String code) {
        if (userService.verify(code)) {
            return "<html>\n" + "<header><title>Camellia Account Verification</title></header>\n" +
            "<body>\n" + "<h1> Account Verified </h1>\n" + "<a href=\"" + homepage + "\">Go to the home page</a>" + "</body>\n" + "</html>";
        } else {
            return "<html>\n" + "<header><title>Camellia Account Verification</title></header>\n" +
            "<body>\n" + "<h1> Verification Failed. If something went wrong, please reach our team.</h1>\n" + "<a href=\"" + homepage + "\">Go to the home page</a>" + "</body>\n" + "</html>";
        }
    }

    private String getSiteURL(HttpServletRequest request) {
        String siteURL = request.getRequestURL().toString();
        return siteURL.replace(request.getServletPath(), "");
    }  


    @Value("${homepage.path}")
    private String homepage;


    public boolean checkRoleRegistered(){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User u = userService.getUserByEmail(auth.getName());

        return u != null && (u.getRolesList().contains("REGISTERED") || u.getRolesList().contains("MOD") || u.getRolesList().contains("ADMIN"));

    }

    public boolean checkRole(){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User u = userService.getUserByEmail(auth.getName());

        return u != null && (u.getRolesList().contains("MOD") || u.getRolesList().contains("ADMIN"));
    }

    public boolean checkAdminRole(){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User u = userService.getUserByEmail(auth.getName());

        return u != null && u.getRolesList().contains("ADMIN");
    }
}
