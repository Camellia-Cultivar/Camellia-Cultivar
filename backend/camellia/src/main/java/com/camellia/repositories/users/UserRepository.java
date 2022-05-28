package com.camellia.repositories.users;

import com.camellia.models.users.User;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User, Long>{
    User findById(long id); 
    User findByEmail(String email);
    User findByVerificationCode(String verificationCode);
}
