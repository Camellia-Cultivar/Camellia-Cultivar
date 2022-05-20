package com.camellia.services.specimens;

import com.camellia.repositories.specimens.SpecimenRepository;
import com.camellia.models.specimens.Specimen;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

@Service
public class SpecimenService {
    @Autowired
    private SpecimenRepository repository;

    public Page<Specimen> getSpecimens(Pageable pageable) {
        return repository.findAll(pageable);
    }

    public List<Specimen> getSpecimens() {
        return repository.findAll();
    }

    public Specimen getSpecimenById(long id) {
        return repository.findById((long) id);
    }
}
