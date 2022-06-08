package com.camellia.services.specimens;

import com.camellia.mappers.SpecimenMapper;
import com.camellia.models.specimens.ReferenceSpecimenView;
import com.camellia.models.specimens.Specimen;

import com.camellia.models.specimens.SpecimenDto;
import com.camellia.repositories.specimens.SpecimenRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

@Service
public class ReferenceSpecimenService {
    @Autowired
    private SpecimenRepository specimenRepository;

    public Page<Specimen> getReferenceSpecimens(Pageable pageable) {
        return specimenRepository.findAllReference(pageable);
    }

    public List<Specimen> getReferenceSpecimens() {
        return specimenRepository.findAllReference();
    }

    public List<ReferenceSpecimenView> getReferenceSpecimensView() {
        return specimenRepository.findReferenceBy();
    }

    public Specimen getReferenceSpecimenById(long id) {
        return specimenRepository.findReferenceById(id);
    }

    public SpecimenDto demoteToToIdentify(long id) {
        Specimen demotingSpecimen = this.getReferenceSpecimenById(id);
        if (demotingSpecimen == null)
            return null;

        demotingSpecimen.demoteToToIdentify();
        specimenRepository.saveAndFlush(demotingSpecimen);
        return SpecimenMapper.MAPPER.specimenToSpecimenDTO(demotingSpecimen);
    }
}
