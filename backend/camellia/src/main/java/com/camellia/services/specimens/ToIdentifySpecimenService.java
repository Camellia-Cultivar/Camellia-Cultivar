package com.camellia.services.specimens;

import com.camellia.mappers.SpecimenMapper;
import com.camellia.models.cultivars.Cultivar;
import com.camellia.models.specimens.Specimen;
import com.camellia.models.specimens.SpecimenDto;
import com.camellia.repositories.specimens.SpecimenRepository;

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
    private SpecimenRepository specimenRepository;

    public Page<Specimen> getToIdentifySpecimens(Pageable pageable) {
        return specimenRepository.findAllToIdentify(pageable);
    }

    public List<Specimen> getToIdentifySpecimens() {
        return specimenRepository.findAllToIdentify();
    }

    public Specimen getToIdentifySpecimenById(long id) {
        return specimenRepository.findToIdentifyById(id);
    }

    public void updateVotes(Specimen specimen, Map<Cultivar, Float> votes){
        specimen.setCultivarProbabilities(votes);
    }

    public List<Specimen> getRecentlyUploaded() {
        return specimenRepository.findAllToIdentifyBy(
                PageRequest.of(0, 10, Sort.by("specimenId").descending())
        );
    }

    public SpecimenDto promoteToReferenceFromId(long id) {
        Specimen promotingSpecimen = this.getToIdentifySpecimenById(id);
        if (promotingSpecimen == null)
            return null;

        promotingSpecimen.promoteToReference();
        specimenRepository.saveAndFlush(promotingSpecimen);
        return SpecimenMapper.MAPPER.specimenToSpecimenDTO(promotingSpecimen);
    }
}
