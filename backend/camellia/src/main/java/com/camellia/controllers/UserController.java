package com.camellia.controllers;

import java.io.UnsupportedEncodingException;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import com.camellia.models.users.RegisteredUser;
import com.camellia.models.users.User;
import com.camellia.services.users.AdministratorUserService;
import com.camellia.services.users.ModeratorUserService;
import com.camellia.services.users.RegisteredUserService;
import com.camellia.services.users.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.MailException;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/users")
public class UserController {
    @Autowired
    private UserService userService;

    @Autowired
    private RegisteredUserService registeredUserService;

    @Autowired
    private ModeratorUserService moderatorUserService;

    @Autowired
    private AdministratorUserService administratorUserService;

    @PostMapping(value="/signup", consumes = {MediaType.APPLICATION_JSON_VALUE})
    public ResponseEntity<String> createUser(@Valid @RequestBody RegisteredUser user, HttpServletRequest request) throws MailException, UnsupportedEncodingException, MessagingException{
        return registeredUserService.addRegisteredUser(user, getSiteURL(request));
    }

    @GetMapping(value="/{id}")
    public ResponseEntity<String> getProfile(@PathVariable(value = "id") long id){
        return userService.getUserProfile(id);
    }

    @PutMapping(value="/{id}", consumes = {MediaType.APPLICATION_JSON_VALUE})
    public ResponseEntity<String> editProfile(@Valid @RequestBody User tempUser, @PathVariable(value = "id") long id){
        return this.userService.editProfile( tempUser, id );
    }

    @GetMapping(value="/verify")
    public String verifyUser(@Param("code") String code) {
        if (userService.verify(code)) {
            return "Account is verified";
        } else {
            return "Verification failed";
        }
    }


    private String getSiteURL(HttpServletRequest request) {
        String siteURL = request.getRequestURL().toString();
        return siteURL.replace(request.getServletPath(), "");
    }  
}
