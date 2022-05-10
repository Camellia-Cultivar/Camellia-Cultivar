package com.camellia.repositories.users;

import com.camellia.models.users.RegisteredUser;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface RegisteredUserRepository extends JpaRepository<RegisteredUser, Long>{
    
}
