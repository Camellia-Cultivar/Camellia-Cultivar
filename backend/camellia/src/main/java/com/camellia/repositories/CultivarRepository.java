package com.camellia.repositories;

import com.camellia.models.Cultivar;

import org.springframework.data.jpa.repository.JpaRepository;
//import org.springframework.stereotype.Repository;

//@Repository
public interface CultivarRepository extends JpaRepository<Cultivar, Long>{
    Cultivar findById(long id);
    
}
