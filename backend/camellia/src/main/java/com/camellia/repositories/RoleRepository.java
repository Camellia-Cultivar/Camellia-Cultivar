package com.camellia.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.camellia.models.users.Role;

public interface RoleRepository extends JpaRepository<Role, Long> {
    Role findByName(String name);
}
