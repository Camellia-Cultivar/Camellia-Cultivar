package com.camellia.services.users;

import com.camellia.repositories.users.AdministratorUserRepository;
import com.camellia.models.users.AdministratorUser;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

@Service
public class AdministratorUserService {
    @Autowired
    private AdministratorUserRepository repository;

    public Page<AdministratorUser> getAdministratorUsers(Pageable pageable) {
        return repository.findAll(pageable);
    }

    public List<AdministratorUser> getAdministratorUsers() {
        return repository.findAll();
    }

    public AdministratorUser getAdministratorUserById(long id) {
        return repository.findById(id);
    }
}
