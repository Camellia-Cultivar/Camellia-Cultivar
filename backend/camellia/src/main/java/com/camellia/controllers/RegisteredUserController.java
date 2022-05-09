package com.camellia.controllers;

import com.camellia.services.users.RegisteredUserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/users")
public class RegisteredUserController {
    
    @Autowired
    private RegisteredUserService reg_user_service;

    @GetMapping
    public void verifyLogin(){

    }

    @PostMapping
    public void createUser(){

    }

    @GetMapping(value="/{id}")
    public void getProfile(){

    }

    @PutMapping(value="/{id}")
    public void editProfile(){

    }

}
