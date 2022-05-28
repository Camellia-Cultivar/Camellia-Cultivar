package com.camellia.repositories;

import com.camellia.models.Photo;
import com.camellia.models.specimens.Specimen;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Set;

public interface PhotoRepository extends JpaRepository<Photo, Long> {
    Photo getPhotoByPhotoId(Long id);
    Set<Photo> getPhotosBySpecimen(Specimen specimen);
}
