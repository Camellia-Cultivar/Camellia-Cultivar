package com.camellia.repositories.requests;

import com.camellia.models.requests.CultivarRequest;

import org.springframework.data.jpa.repository.JpaRepository;
//import org.springframework.stereotype.Repository;

//@Repository
public interface CultivarRequestRepository extends JpaRepository<CultivarRequest, Long>{
    CultivarRequest findById(long id);
}
