package com.camellia.repositories.specimens;

import com.camellia.models.specimens.Specimen;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface ToIdentifySpecimenRepository extends JpaRepository<Specimen, Long>{
    @Override
    @Query("SELECT s FROM Specimen s WHERE s.specimenType = 'TO_IDENTIFY'")
    Page<Specimen> findAll(Pageable pageable);

    @Override
    @Query("SELECT s FROM Specimen s WHERE s.specimenType = 'TO_IDENTIFY'")
    List<Specimen> findAll();

    @Query("SELECT specimenId FROM Specimen WHERE specimenId = :id AND specimenType = 'TO_IDENTIFY'")
    Specimen findById(@Param("id") long id);

    @Query("SELECT specimenId FROM Specimen WHERE specimenType = 'TO_IDENTIFY'")
    List<Long> findAllIds();

    @Query("SELECT s FROM Specimen s WHERE s.specimenType = 'TO_IDENTIFY'")
    List<Specimen> findAllBy(Pageable pageable);
}
