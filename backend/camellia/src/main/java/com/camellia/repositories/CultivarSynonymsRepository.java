package com.camellia.repositories;

import com.camellia.models.CultivarSynonyms;

import org.springframework.data.jpa.repository.JpaRepository;
//import org.springframework.stereotype.Repository;

//@Repository
public interface CultivarSynonymsRepository extends JpaRepository<CultivarSynonyms, Long>{
    CultivarSynonyms findById(long id);  
}
