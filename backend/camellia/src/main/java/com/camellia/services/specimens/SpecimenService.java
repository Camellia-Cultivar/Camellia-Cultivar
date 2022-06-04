package com.camellia.services.specimens;

import com.camellia.models.characteristics.CharacteristicValue;
import com.camellia.repositories.specimens.SpecimenRepository;
import com.camellia.models.specimens.Specimen;

import com.camellia.services.characteristics.CharacteristicValueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class SpecimenService {
    @Autowired
    private SpecimenRepository specimenRepository;

    @Autowired
    private CharacteristicValueService characteristicValueService;

    public Page<Specimen> getSpecimens(Pageable pageable) {
        return specimenRepository.findAll(pageable);
    }

    public List<Specimen> getSpecimens() {
        return specimenRepository.findAll();
    }

    public Specimen getSpecimenById(long id) {
        return specimenRepository.findById(id);
    }

    public Specimen saveSpecimen(Specimen specimen){
        Set<CharacteristicValue> values = specimen.getCharacteristicValues().stream()
                .map(characteristicValueService::getOrSaveCharacteristicValue)
                .filter(Objects::nonNull)
                .collect(Collectors.toSet());

        specimen.setCharacteristicValues(values);

        return specimenRepository.save(specimen);
    }

    public String deleteSpecimen(long id) {
        specimenRepository.deleteById(id);
        return "Specimen with id="+ id +" removed!";
    }

    public Long getSpecimenCount() {
        return specimenRepository.count();
    }

    public Long getSpecimenPhotosCount() {return specimenRepository.countAllPhotos();}
}
