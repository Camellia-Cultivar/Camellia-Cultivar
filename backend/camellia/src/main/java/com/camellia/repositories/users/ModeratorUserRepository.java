package com.camellia.repositories.users;

import com.camellia.models.users.ModeratorUser;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ModeratorUserRepository extends JpaRepository<ModeratorUser, Long>{
    
}
