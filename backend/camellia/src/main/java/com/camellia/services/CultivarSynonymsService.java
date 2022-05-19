package com.camellia.services;

import com.camellia.repositories.CultivarSynonymsRepository;
import com.camellia.models.CultivarSynonyms;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

@Service
public class CultivarSynonymsService {
    @Autowired
    private CultivarSynonymsRepository repository;

    public Page<CultivarSynonyms> getCultivarSynonyms(Pageable pageable) {
        return repository.findAll(pageable);
    }

    public List<CultivarSynonyms> getCultivarSynonyms() {
        return repository.findAll();
    }

    public CultivarSynonyms getCultivarSynonymsById(long id) {
        return repository.findById((long) id);
    }
}
