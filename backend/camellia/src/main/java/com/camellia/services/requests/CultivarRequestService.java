package com.camellia.services.requests;

import com.camellia.repositories.requests.CultivarRequestRepository;
import com.camellia.models.requests.CultivarRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

@Service
public class CultivarRequestService {
    @Autowired
    private CultivarRequestRepository repository;

    public Page<CultivarRequest> getCultivarRequests(Pageable pageable) {
        return repository.findAll(pageable);
    }

    public List<CultivarRequest> getCultivarRequests() {
        return repository.findAll();
    }

    public CultivarRequest getCultivarRequestById(long id) {
        return repository.findById(id);
    }
}
