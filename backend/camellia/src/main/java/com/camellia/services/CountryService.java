package com.camellia.services;

import com.camellia.repositories.CountryRepository;
import com.camellia.models.Country;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

@Service
public class CountryService {

    @Autowired
    private CountryRepository repository;

    public Page<Country> getCountries(Pageable pageable) {
        return repository.findAll(pageable);
    }

    public List<Country> getCountries() {
        return repository.findAll();
    }

    public Country getCountryById(long id) {
        return repository.findById((long) id);
    }


    
}
