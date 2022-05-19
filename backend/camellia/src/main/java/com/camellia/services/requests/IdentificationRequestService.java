package com.camellia.services.requests;

import com.camellia.repositories.requests.IdentificationRequestRepository;
import com.camellia.models.requests.IdentificationRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

@Service
public class IdentificationRequestService {
    @Autowired
    private IdentificationRequestRepository repository;

    public Page<IdentificationRequest> getIdentificationRequests(Pageable pageable) {
        return repository.findAll(pageable);
    }

    public List<IdentificationRequest> getIdentificationRequests() {
        return repository.findAll();
    }

    public IdentificationRequest getIdentificationRequestById(long id) {
        return repository.findById((long) id);
    }
}
