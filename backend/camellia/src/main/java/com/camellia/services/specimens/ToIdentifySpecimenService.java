package com.camellia.services.specimens;

import com.camellia.repositories.specimens.ToIdentifySpecimenRepository;
import com.camellia.models.specimens.ToIdentifySpecimen;
import com.camellia.models.cultivars.Cultivar;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.*;

@Service
public class ToIdentifySpecimenService {
    @Autowired
    private ToIdentifySpecimenRepository repository;

    public Page<ToIdentifySpecimen> getToIdentifySpecimens(Pageable pageable) {
        return repository.findAll(pageable);
    }

    public List<ToIdentifySpecimen> getToIdentifySpecimens() {
        return repository.findAll();
    }

    public ToIdentifySpecimen getToIdentifySpecimenById(long id) {
        return repository.findById((long) id);
    }

    public void updateVotes(ToIdentifySpecimen specimen, Map<Cultivar, Integer> votes){
        specimen.setCultivar_votes(votes);
    }
}
