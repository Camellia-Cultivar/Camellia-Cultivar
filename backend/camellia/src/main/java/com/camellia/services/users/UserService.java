package com.camellia.services.users;

import com.camellia.models.users.User;
import com.camellia.repositories.users.UserRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

@Service
public class UserService {
    @Autowired
    private UserRepository repository;

    @Autowired
    private RegisteredUserService registeredUserService;

    @Autowired
    private ModeratorUserService moderatorUserService;

    @Autowired
    private AdministratorUserService administratorUserService;

    public ResponseEntity<String> login(User user){
        User savedUser = this.repository.findByEmail(user.getEmail());
        if(savedUser != null){
            if(savedUser.getPassword().equals(user.getPassword()))
                return ResponseEntity.status(HttpStatus.ACCEPTED).body( "userId: ".concat(savedUser.getUserId() + ""));
            else
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Login failed");
        }
        else
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("User not found");
    }

//    public ResponseEntity<String> addUser( User user){
//        System.out.println("add");
//        this.repository.save(user);
//        return ResponseEntity.status(HttpStatus.ACCEPTED).body("success");
//    }

    public ResponseEntity<String> getUserProfile(long id){
        try{
            return ResponseEntity.status(HttpStatus.ACCEPTED).body(this.repository.findById(id).profile());
        } catch (NullPointerException e){
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("User not found");
        }
    }


    public ResponseEntity<String> editProfile(User tempUser){
        User user;
        try{
            user = this.repository.findByEmail(tempUser.getEmail());
        } catch( NullPointerException e){
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("User not found");
        }
        user.setProfilePhoto(tempUser.getProfilePhoto());
        user.setFirstName(tempUser.getFirstName());
        user.setLastName(tempUser.getLastName());
        //user.setEmail(tempUser.getEmail());
        user.setPassword(tempUser.getPassword());
        this.repository.save(user);
        return ResponseEntity.status(HttpStatus.CREATED).body(user.profile());
    }
}
