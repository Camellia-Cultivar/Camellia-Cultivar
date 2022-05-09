package com.camellia.repositories.requests;

import com.camellia.models.requests.IdentificationRequest;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface IdentificationRequestRepository extends JpaRepository<IdentificationRequest, Long>{
    
}
