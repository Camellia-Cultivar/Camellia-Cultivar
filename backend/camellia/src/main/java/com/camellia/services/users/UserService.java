package com.camellia.services.users;

import com.camellia.models.users.User;
import com.camellia.repositories.users.UserRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class UserService {
    @Autowired
    private UserRepository repository;

    @Autowired
    BCryptPasswordEncoder bCryptPasswordEncoder;


    public ResponseEntity<String> getUserProfile(long id){
        User attemptingUser = repository.findById(id);
        try{
            if(!emailVerification(attemptingUser.getEmail()))
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Could not retrieve profile");
            else
                return ResponseEntity.status(HttpStatus.ACCEPTED).body(this.repository.findByEmail(attemptingUser.getEmail()).getProfile());
        } catch (NullPointerException e){
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("User not found");
        }
    }


    public ResponseEntity<String> editProfile(User tempUser, long id){
        if( tempUser.getFirstName().isEmpty() && tempUser.getLastName().isEmpty() 
                && tempUser.getPassword().isEmpty() && tempUser.getProfilePhoto().isEmpty())
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Invalid user data");

        if(!emailVerification(repository.findById(id).getEmail()))
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Invalid user profile");

        User user;
        try{
            user = this.repository.findByEmail(tempUser.getEmail());
        } catch( NullPointerException e){
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("User not found");
        }

        if(!tempUser.getProfilePhoto().isEmpty())
            user.setProfilePhoto(tempUser.getProfilePhoto());
        if(!tempUser.getFirstName().isEmpty())
            user.setFirstName(tempUser.getFirstName());
        if(!tempUser.getLastName().isEmpty())
            user.setLastName(tempUser.getLastName());
        if(!tempUser.getPassword().isEmpty())
            user.setPassword(bCryptPasswordEncoder.encode(tempUser.getPassword()));
            
        this.repository.save(user);
        return ResponseEntity.status(HttpStatus.CREATED).body(user.getProfile());
    }

    public boolean emailVerification(String email){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        return auth.getName().equals(email);
    }

    public User getUserByEmail(String email) {
        return repository.findByEmail(email);
    }


    public boolean verify(String verificationCode) {
        User user = repository.findByVerificationCode(verificationCode);
         
        if (user == null || user.isVerified()) {
            return false;
        } else {
            user.setVerificationCode(null);
            user.setVerified(true);
            repository.save(user);
             
            return true;
        } 
    }

    public Long getUserCount() {
        return repository.count();
    }

    public User getUserById(long id){
        return repository.findById(id);
    }
}
