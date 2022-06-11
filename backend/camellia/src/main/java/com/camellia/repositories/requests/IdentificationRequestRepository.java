package com.camellia.repositories.requests;

import com.camellia.models.requests.IdentificationRequest;

import com.camellia.models.requests.IdentificationRequestView;
import com.camellia.models.users.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface IdentificationRequestRepository extends JpaRepository<IdentificationRequest, Long>{
    IdentificationRequest findById(long id);

    @Query(value =
            "SELECT r FROM IdentificationRequest r " +
                    "WHERE r.toIdentifySpecimen.specimenType = com.camellia.models.specimens.SpecimenType.FOR_APPROVAL " +
                    "ORDER BY r.submissionDate ASC")
    Page<IdentificationRequest> findAllByOrderBySubmissionDateAscAndByPage(Pageable pageable);

    List<IdentificationRequestView> findAllByRegUser(User user);
}
