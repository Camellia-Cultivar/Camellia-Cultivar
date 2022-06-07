package com.camellia.repositories.specimens;

import com.camellia.models.specimens.ReferenceSpecimenView;
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


    // SPECIMENS TO IDENTIFY
    @Query("SELECT s FROM Specimen s WHERE s.specimenType = 'TO_IDENTIFY'")
    Page<Specimen> findAllToIdentify(Pageable pageable);

    @Query("SELECT s FROM Specimen s WHERE s.specimenType = 'TO_IDENTIFY'")
    List<Specimen> findAllToIdentify();

    @Query("SELECT s FROM Specimen s WHERE s.specimenId = :id AND s.specimenType = 'TO_IDENTIFY'")
    Specimen findToIdentifyById(@Param("id") long id);

    @Query("SELECT specimenId FROM Specimen WHERE specimenType = 'TO_IDENTIFY'")
    List<Long> findAllToIdentifyIds();

    @Query("SELECT s FROM Specimen s WHERE s.specimenType = 'TO_IDENTIFY'")
    List<Specimen> findAllToIdentifyBy(Pageable pageable);


    // REFERENCE SPECIMENS
    @Query("SELECT s FROM Specimen s WHERE s.specimenType = 'REFERENCE'")
    Page<Specimen> findAllReference(Pageable pageable);

    @Query("SELECT s FROM Specimen s WHERE s.specimenType = 'REFERENCE'")
    List<Specimen> findAllReference();
    @Query(value = "SELECT s FROM Specimen s WHERE s.specimenType = 'REFERENCE' AND s.specimenId = :id")
    Specimen findReferenceById(@Param("id") long id);

    @Query(value = "SELECT s.specimenId FROM Specimen s WHERE s.specimenType = 'REFERENCE'")
    List<Long> findAllReferenceIds();

    @Query(value = "SELECT s FROM Specimen s WHERE s.specimenType = 'REFERENCE'")
    List<ReferenceSpecimenView> findReferenceBy();

}
