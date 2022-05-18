package com.camellia.services.users;

import com.camellia.repositories.users.RegisteredUserRepository;
import com.camellia.models.users.RegisteredUser;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

@Service
public class RegisteredUserService {
    @Autowired
    private RegisteredUserRepository repository;

    public String addRegisteredUser( RegisteredUser user){
        this.repository.save(user);
        return "success";
    }

    public String getUserProfile(long id){
        
        return this.repository.findById(id).profile();
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
        user.setProfile_photo(tempUser.getProfile_photo());
        user.setFirst_name(tempUser.getFirst_name());
        user.setLast_name(tempUser.getLast_name());
        user.setEmail(tempUser.getEmail());
        user.setPassword(tempUser.getPassword());
        this.repository.save(user);
        return user.profile();
    }
}
