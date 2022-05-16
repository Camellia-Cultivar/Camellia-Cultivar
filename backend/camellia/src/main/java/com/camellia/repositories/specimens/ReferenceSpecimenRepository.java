package com.camellia.repositories.specimens;

import com.camellia.models.specimens.ReferenceSpecimen;

import org.springframework.data.jpa.repository.JpaRepository;
//import org.springframework.stereotype.Repository;

//@Repository
public interface ReferenceSpecimenRepository extends JpaRepository<ReferenceSpecimen, Long>{
    ReferenceSpecimen findById(long id);
}
