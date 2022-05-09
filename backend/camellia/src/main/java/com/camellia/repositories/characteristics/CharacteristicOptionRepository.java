package com.camellia.repositories.characteristics;

import com.camellia.models.characteristics.CharacteristicOption;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CharacteristicOptionRepository extends JpaRepository<CharacteristicOption, Long>{
    
}
