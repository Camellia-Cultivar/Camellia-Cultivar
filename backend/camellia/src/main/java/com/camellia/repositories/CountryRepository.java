package com.camellia.repositories;

import com.camellia.models.Country;

import org.springframework.data.jpa.repository.JpaRepository;
//import org.springframework.stereotype.Repository;

//@Repository
public interface CountryRepository extends JpaRepository<Country, Long>{
    Country findById(long id);
}
