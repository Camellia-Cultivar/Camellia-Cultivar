package com.camellia.repositories.requests;

import com.camellia.models.requests.IdentificationRequest;

import com.camellia.models.requests.IdentificationRequestView;
import com.camellia.models.users.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface IdentificationRequestRepository extends JpaRepository<IdentificationRequest, Long>{
    IdentificationRequest findById(long id);

    Page<IdentificationRequest> findAllByOrderBySubmissionDateAsc(Pageable pageable);

    List<IdentificationRequestView> findAllByRegUser(User user);
}
