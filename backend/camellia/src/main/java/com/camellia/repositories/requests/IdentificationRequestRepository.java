package com.camellia.repositories.requests;

import com.camellia.models.requests.IdentificationRequest;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface IdentificationRequestRepository extends JpaRepository<IdentificationRequest, Long>{
    IdentificationRequest findById(long id);

    Page<IdentificationRequest> findAllByOrderBySubmissionDateAsc(Pageable pageable);
}
