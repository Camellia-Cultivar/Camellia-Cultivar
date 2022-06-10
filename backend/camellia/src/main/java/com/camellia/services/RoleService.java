package com.camellia.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.camellia.models.users.Role;
import com.camellia.repositories.RoleRepository;

@Service
public class RoleService {
    
    @Autowired
    private RoleRepository repository;

    public Role getRoleByName(String name){
        return repository.findByName(name);
    }
}
