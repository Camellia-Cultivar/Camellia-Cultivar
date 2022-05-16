package com.camellia.repositories.specimens;

import com.camellia.models.specimens.ToIdentifySpecimen;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ToIdentifySpecimenRepository extends JpaRepository<ToIdentifySpecimen, Long>{
    
}
