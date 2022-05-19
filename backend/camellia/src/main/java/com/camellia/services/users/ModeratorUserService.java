package com.camellia.services.users;

import com.camellia.repositories.users.ModeratorUserRepository;
import com.camellia.models.users.ModeratorUser;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

@Service
public class ModeratorUserService {
    @Autowired
    private ModeratorUserRepository repository;

    public Page<ModeratorUser> getModeratorUsers(Pageable pageable) {
        return repository.findAll(pageable);
    }

    public List<ModeratorUser> getModeratorUsers() {
        return repository.findAll();
    }

    public ModeratorUser getModeratorUserById(long id) {
        return repository.findById((long) id);
    }
}
