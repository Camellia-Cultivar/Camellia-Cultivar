package com.camellia.controllers;

import javax.validation.Valid;

import com.camellia.models.users.RegisteredUser;
import com.camellia.models.users.User;
import com.camellia.services.users.RegisteredUserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/users/registered")
public class RegisteredUserController {
    
//    @Autowired
//    private RegisteredUserService reg_user_service;
//
//    @GetMapping
//    public String verifyLogin(@Valid @RequestBody RegisteredUser user){
//        return reg_user_service.login(user);
//    }
//
//    @PostMapping(value="/")
//    public String createUser(@Valid @RequestBody RegisteredUser user){
//        System.out.println("here");
//        return reg_user_service.addRegisteredUser(user);
//    }
//
//    @GetMapping(value="/{id}")
//    public String getProfile(@PathVariable(value = "id") long id){
//        return reg_user_service.getUserProfile(id);
//    }
//
//    @PutMapping(value="/{id}")
//    public String editProfile(@Valid @RequestBody RegisteredUser tempUser){
//        return this.reg_user_service.editProfile( tempUser );
//    }

}
