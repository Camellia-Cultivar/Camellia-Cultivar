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

    public Page<RegisteredUser> getRegisteredUsers(Pageable pageable) {
        return repository.findAll(pageable);
    }

    public List<RegisteredUser> getRegisteredUsers() {
        return repository.findAll();
    }

    public RegisteredUser getRegisteredUserById(long id) {
        return repository.findById((long) id);
    }
}
