package com.camellia.services.specimens;

import com.camellia.repositories.specimens.SpecimenRepository;
import com.camellia.models.specimens.Specimen;
import com.camellia.models.Country;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
//import org.springframework.data.repository.query.RepositoryQuery;

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
        return repository.findById((long)id);
    }

    public List<Specimen> getSpecimenByCountry(Country country){
        return repository.findByCountry(country);
    }

    public Specimen saveSpecimen(Specimen specimen){
        return repository.save(specimen);
    }

    public String deleteSpecimen(long id) {
        repository.deleteById(id);
        return "Specimen with id="+ id +" removed!";
    }

    public Long getSpecimenCount() {
        return repository.count();
    }
}
