package com.camellia.repositories.specimens;

import com.camellia.models.specimens.ToIdentifySpecimen;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface ToIdentifySpecimenRepository extends JpaRepository<ToIdentifySpecimen, Long>{
    ToIdentifySpecimen findById(long id);

    @Query("SELECT specimenId FROM ToIdentifySpecimen")
    List<Long> findAllIds();

    List<ToIdentifySpecimen> findFirst10ByOrderBySpecimenIdDesc();
}
