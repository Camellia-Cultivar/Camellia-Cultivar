package com.camellia.repositories.specimens;

import com.camellia.models.specimens.Specimen;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
public interface SpecimenRepository extends JpaRepository<Specimen, Long>{
    Specimen findById(long id);

    @Query(
            value = "SELECT COUNT(*) FROM specimen_photos",
            nativeQuery = true
    )
    Long countAllPhotos();

}
