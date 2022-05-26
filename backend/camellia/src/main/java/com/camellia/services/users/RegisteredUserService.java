package com.camellia.services.users;

import java.util.List;

import com.camellia.models.users.RegisteredUser;
import com.camellia.repositories.users.RegisteredUserRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;



@Service
public class RegisteredUserService {
    @Autowired
    private RegisteredUserRepository repository;

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;
//    public String login(RegisteredUser user){
//        RegisteredUser savedUser = this.repository.findByEmail(user.getEmail());
//        if(savedUser != null){
//            if(savedUser.getPassword().equals(user.getPassword()))
//                return "user_id:";
//            else
//                return "status: login failed";
//        }
//        else
//            return "User not found";
//    }

    public ResponseEntity<String> addRegisteredUser( RegisteredUser user){
        try{
            if(repository.findByEmail(user.getEmail()) != null){
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("User already exists");

            }
            user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
            this.repository.save(user);
        } catch(  DataIntegrityViolationException e){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Invalid data. User was not created");
        }
        
        
        return ResponseEntity.status(HttpStatus.CREATED).body("User Added");
    }

    public ResponseEntity<String> getUserProfile(long id){
        return ResponseEntity.status(HttpStatus.ACCEPTED).body(this.repository.findById(id).profile());
    }

    public Page<RegisteredUser> getRegisteredUsers(Pageable pageable) {
        return repository.findAll(pageable);
    }

    public List<RegisteredUser> getRegisteredUsers() {
        return repository.findAll();
    }

    public RegisteredUser getRegisteredUserById(long id) {
        return repository.findById((long) id);
    }

    public String editProfile(RegisteredUser tempUser){
        RegisteredUser user = this.repository.findByEmail(tempUser.getEmail());
        user.setProfilePhoto(tempUser.getProfilePhoto());
        user.setFirstName(tempUser.getFirstName());
        user.setLastName(tempUser.getLastName());
        //user.setEmail(tempUser.getEmail());
        user.setPassword(tempUser.getPassword());
        this.repository.save(user);
        return user.profile();
    }
}
