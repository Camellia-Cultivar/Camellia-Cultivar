package com.camellia.services.specimens;

import com.camellia.models.cultivars.Cultivar;
import com.camellia.models.specimens.Specimen;
import com.camellia.repositories.specimens.ToIdentifySpecimenRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.*;

@Service
public class ToIdentifySpecimenService {
    @Autowired
    private ToIdentifySpecimenRepository repository;

    public Page<Specimen> getToIdentifySpecimens(Pageable pageable) {
        return repository.findAll(pageable);
    }

    public List<Specimen> getToIdentifySpecimens() {
        return repository.findAll();
    }

    public Specimen getToIdentifySpecimenById(long id) {
        return repository.findById(id);
    }

    public void updateVotes(Specimen specimen, Map<Cultivar, Float> votes){
        specimen.setCultivarProbabilities(votes);
    }

    public List<Specimen> getRecentlyUploaded() {
        return repository.findAllBy(PageRequest.of(0, 10, Sort.by("specimenId").descending()));
    }
}
