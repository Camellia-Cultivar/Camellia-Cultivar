package com.camellia.repositories.specimens;

import com.camellia.models.specimens.Specimen;
import com.camellia.models.Country;

import org.springframework.data.jpa.repository.JpaRepository;
// import org.springframework.data.jpa.repository.Query;
// import org.springframework.data.repository.query.Param;
//import org.springframework.stereotype.Repository;

import java.util.List;

//@Repository
public interface SpecimenRepository extends JpaRepository<Specimen, Long>{
    Specimen findById(long id);

    List<Specimen> findByCountry(Country country);

    
}
