package com.camellia.services.requests;

import com.camellia.repositories.requests.ReportRequestRepository;
import com.camellia.models.requests.ReportRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

@Service
public class ReportRequestService {
    @Autowired
    private ReportRequestRepository repository;

    public Page<ReportRequest> getReportRequests(Pageable pageable) {
        return repository.findAll(pageable);
    }

    public List<ReportRequest> getReportRequests() {
        return repository.findAll();
    }

    public ReportRequest getReportRequestById(long id) {
        return repository.findById((long) id);
    }
}
