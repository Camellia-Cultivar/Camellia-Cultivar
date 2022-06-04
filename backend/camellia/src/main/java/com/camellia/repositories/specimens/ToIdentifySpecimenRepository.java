package com.camellia.repositories.specimens;

import com.camellia.models.specimens.ToIdentifySpecimen;

import org.springframework.data.jpa.repository.JpaRepository;

public interface ToIdentifySpecimenRepository extends JpaRepository<ToIdentifySpecimen, Long>{
    ToIdentifySpecimen findById(long id);
}
