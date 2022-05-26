package com.camellia.controllers;

import javax.validation.Valid;

import com.camellia.models.users.RegisteredUser;
import com.camellia.models.users.User;
import com.camellia.services.users.AdministratorUserService;
import com.camellia.services.users.ModeratorUserService;
import com.camellia.services.users.RegisteredUserService;
import com.camellia.services.users.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
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

    @GetMapping(value="")
    public ResponseEntity<String> verifyLogin(@Valid @RequestBody User user){
        System.out.println("login");
        return userService.login(user);
    }

    @PostMapping(value="/signup")
    public ResponseEntity<String> createUser(@Valid @RequestBody RegisteredUser user){
        System.out.println("create");
        return registeredUserService.addRegisteredUser(user);
    }

    @GetMapping(value="/{id}")
    public ResponseEntity<String> getProfile(@PathVariable(value = "id") long id){
        return userService.getUserProfile(id);
    }

    @PutMapping(value="")
    public ResponseEntity<String> editProfile(@Valid @RequestBody User tempUser){
        return this.userService.editProfile( tempUser );
    }
}
