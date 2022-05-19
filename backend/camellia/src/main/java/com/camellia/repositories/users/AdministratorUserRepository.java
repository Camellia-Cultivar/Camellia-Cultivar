package com.camellia.repositories.users;

import com.camellia.models.users.AdministratorUser;

import org.springframework.data.jpa.repository.JpaRepository;
//import org.springframework.stereotype.Repository;

//@Repository
public interface AdministratorUserRepository extends JpaRepository<AdministratorUser, Long>{
    AdministratorUser findById(long id);
}
