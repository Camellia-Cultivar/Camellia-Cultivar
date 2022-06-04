package com.camellia.repositories.specimens;

import com.camellia.models.specimens.ReferenceSpecimen;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
//import org.springframework.stereotype.Repository;
import org.springframework.data.jpa.repository.Query;

//@Repository
public interface ReferenceSpecimenRepository extends JpaRepository<ReferenceSpecimen, Long>{
    ReferenceSpecimen findById(long id);

    @Query("SELECT specimen_id FROM ReferenceSpecimen")
    List<Long> findAllIds(); 
}
