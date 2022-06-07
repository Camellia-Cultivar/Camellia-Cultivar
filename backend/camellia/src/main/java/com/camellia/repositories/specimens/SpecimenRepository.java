package com.camellia.repositories.specimens;

import com.camellia.models.specimens.Specimen;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface SpecimenRepository extends JpaRepository<Specimen, Long>{
    Specimen findById(long id);

    @Query(
            value = "SELECT COUNT(*) FROM specimen_photos",
            nativeQuery = true
    )
    Long countAllPhotos();

    @Query("SELECT s FROM Specimen s WHERE s.specimenType = 'TO_IDENTIFY'")
    Page<Specimen> findAllToIdentify(Pageable pageable);

    @Query("SELECT s FROM Specimen s WHERE s.specimenType = 'TO_IDENTIFY'")
    List<Specimen> findAllToIdentify();

    @Query("SELECT specimenId FROM Specimen WHERE specimenId = :id AND specimenType = 'TO_IDENTIFY'")
    Specimen findToIdentifyById(@Param("id") long id);

    @Query("SELECT specimenId FROM Specimen WHERE specimenType = 'TO_IDENTIFY'")
    List<Long> findAllToIdentifyIds();

    @Query("SELECT s FROM Specimen s WHERE s.specimenType = 'TO_IDENTIFY'")
    List<Specimen> findAllToIdentifyBy(Pageable pageable);

}
