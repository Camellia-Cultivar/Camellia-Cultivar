package com.camellia.services.cultivars;

import com.camellia.repositories.cultivars.CultivarSynonymsRepository;
import com.camellia.models.cultivars.CultivarSynonyms;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Optional;

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

    public Optional<CultivarSynonyms> getCultivarSynonymsById(Long id) {
        return repository.findById(id);
    }
}
