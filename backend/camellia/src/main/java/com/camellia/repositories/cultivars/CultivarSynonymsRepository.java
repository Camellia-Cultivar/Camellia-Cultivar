package com.camellia.repositories.cultivars;

import com.camellia.models.cultivars.CultivarSynonyms;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;
//import org.springframework.stereotype.Repository;

//@Repository
public interface CultivarSynonymsRepository extends JpaRepository<CultivarSynonyms, Long>{
    @Override
    Optional<CultivarSynonyms> findById(Long id);

    List<CultivarSynonyms> findTop5BySynonymStartsWithIgnoreCase(String substring);
}
