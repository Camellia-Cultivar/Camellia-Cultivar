package com.camellia.services.specimens;

import com.camellia.repositories.specimens.ReferenceSpecimenRepository;
import com.camellia.models.specimens.ReferenceSpecimen;
import com.camellia.models.specimens.SpecimenQuizDTO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

@Service
public class ReferenceSpecimenService {
    @Autowired
    private ReferenceSpecimenRepository repository;

    public Page<ReferenceSpecimen> getReferenceSpecimens(Pageable pageable) {
        return repository.findAll(pageable);
    }

    public List<ReferenceSpecimen> getReferenceSpecimens() {
        return repository.findAll();
    }

    public ReferenceSpecimen getReferenceSpecimenById(long id) {
        return repository.findById((long) id);
    }
}
