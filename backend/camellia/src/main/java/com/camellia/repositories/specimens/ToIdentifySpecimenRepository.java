package com.camellia.repositories.specimens;

import com.camellia.models.specimens.ToIdentifySpecimen;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
//import org.springframework.stereotype.Repository;
import org.springframework.data.jpa.repository.Query;

//@Repository
public interface ToIdentifySpecimenRepository extends JpaRepository<ToIdentifySpecimen, Long>{
    ToIdentifySpecimen findById(long id);

    @Query("SELECT specimen_id FROM ToIdentifySpecimen")
    List<Long> findAllIds(); 
}
