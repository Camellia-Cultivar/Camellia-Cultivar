package com.camellia.services.specimens;

import com.camellia.models.specimens.ReferenceSpecimenView;
import com.camellia.models.specimens.Specimen;
import com.camellia.repositories.specimens.ReferenceSpecimenRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

@Service
public class ReferenceSpecimenService {
    @Autowired
    private ReferenceSpecimenRepository repository;

    public Page<Specimen> getReferenceSpecimens(Pageable pageable) {
        return repository.findAll(pageable);
    }

    public List<Specimen> getReferenceSpecimens() {
        return repository.findAll();
    }

    public List<ReferenceSpecimenView> getReferenceSpecimensView() {
        return repository.findBy();
    }

    public Specimen getReferenceSpecimenById(long id) {
        return repository.findById(id);
    }
}
