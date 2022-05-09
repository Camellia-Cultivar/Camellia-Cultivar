package com.camellia.repositories.specimens;

import com.camellia.models.specimens.Specimen;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SpecimenRepository extends JpaRepository<Specimen, Long>{
    
}
