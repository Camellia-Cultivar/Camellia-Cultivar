package com.camellia.repositories.specimens;

import java.util.List;

import com.camellia.models.specimens.ReferenceSpecimenView;
import com.camellia.models.specimens.Specimen;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface ReferenceSpecimenRepository extends JpaRepository<Specimen, Long>{
    @Query(value = "SELECT s FROM Specimen s WHERE s.specimenType = 'REFERENCE' AND s.specimenId = :id")
    Specimen findById(@Param("id") long id);

    @Query(value = "SELECT s.specimenId FROM Specimen s WHERE s.specimenType = 'REFERENCE'")
    List<Long> findAllIds();

    @Query(value = "SELECT s FROM Specimen s WHERE s.specimenType = 'REFERENCE'")

    List<ReferenceSpecimenView> findBy();
}
