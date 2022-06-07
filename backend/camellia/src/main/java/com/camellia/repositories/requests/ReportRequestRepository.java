package com.camellia.repositories.requests;

import com.camellia.models.requests.ReportRequest;

import org.springframework.data.jpa.repository.JpaRepository;

public interface ReportRequestRepository extends JpaRepository<ReportRequest, Long>{
    ReportRequest findById(long id);

    ReportRequest findTopByOrderBySubmissionDate();
}
