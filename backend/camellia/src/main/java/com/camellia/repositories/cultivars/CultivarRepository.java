package com.camellia.repositories.cultivars;

import com.camellia.models.cultivars.Cultivar;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;
//import org.springframework.stereotype.Repository;

//@Repository
public interface CultivarRepository extends JpaRepository<Cultivar, Long>{
    @Override
    Optional<Cultivar> findById(Long id);

    List<Cultivar> findTop5ByEpithetStartsWithIgnoreCase(String subString);
}
