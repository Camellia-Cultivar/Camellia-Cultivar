package com.camellia.services;

import com.camellia.repositories.ReputationParametersRepository;
import com.camellia.models.ReputationParameters;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

@Service
public class ReputationParametersService {
    @Autowired
    private ReputationParametersRepository repository;

    public Page<ReputationParameters> getReputationParameters(Pageable pageable) {
        return repository.findAll(pageable);
    }

    public List<ReputationParameters> getReputationParameters() {
        return repository.findAll();
    }

    public ReputationParameters getReputationParametersById(long id) {
        return repository.findById((long) id);
    }
}
