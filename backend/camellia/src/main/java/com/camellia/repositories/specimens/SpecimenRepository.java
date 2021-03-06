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
    @Query("SELECT s FROM Specimen s WHERE s.specimenType = com.camellia.models.specimens.SpecimenType.TO_IDENTIFY")
    Page<Specimen> findAllToIdentify(Pageable pageable);

    @Query("SELECT s FROM Specimen s WHERE s.specimenType = com.camellia.models.specimens.SpecimenType.TO_IDENTIFY")
    List<Specimen> findAllToIdentify();

    @Query("SELECT s FROM Specimen s WHERE s.specimenId = :id AND s.specimenType = com.camellia.models.specimens.SpecimenType.TO_IDENTIFY")
    Specimen findToIdentifyById(@Param("id") long id);

    @Query("SELECT specimenId FROM Specimen WHERE specimenType = com.camellia.models.specimens.SpecimenType.TO_IDENTIFY")
    List<Long> findAllToIdentifyIds();

    @Query("SELECT s FROM Specimen s WHERE s.specimenType = com.camellia.models.specimens.SpecimenType.TO_IDENTIFY")
    List<Specimen> findAllToIdentifyBy(Pageable pageable);


    // R SPECIMENS
    @Query("SELECT s FROM Specimen s WHERE s.specimenType = com.camellia.models.specimens.SpecimenType.REFERENCE")
    Page<Specimen> findAllReference(Pageable pageable);

    @Query("SELECT s FROM Specimen s WHERE s.specimenType = com.camellia.models.specimens.SpecimenType.REFERENCE")
    List<Specimen> findAllReference();
    @Query(value = "SELECT s FROM Specimen s WHERE s.specimenType = com.camellia.models.specimens.SpecimenType.REFERENCE AND s.specimenId = :id")
    Specimen findReferenceById(@Param("id") long id);

    @Query(value = "SELECT s.specimenId FROM Specimen s WHERE s.specimenType = com.camellia.models.specimens.SpecimenType.REFERENCE")
    List<Long> findAllReferenceIds();

    @Query(value = "SELECT s FROM Specimen s WHERE s.specimenType = com.camellia.models.specimens.SpecimenType.REFERENCE")
    List<ReferenceSpecimenView> findReferenceBy();

    @Query(nativeQuery = true, value = "SELECT user_id FROM specimen WHERE specimen_id = :id")
    Long findUserById(@Param("id") Long specimenId);
}
