package com.camellia.repositories.requests;

import com.camellia.models.requests.CultivarRequest;

import org.springframework.data.jpa.repository.JpaRepository;

public interface CultivarRequestRepository extends JpaRepository<CultivarRequest, Long>{
    CultivarRequest findById(long id);

    CultivarRequest findTopByOrderBySubmissionDate();
}
