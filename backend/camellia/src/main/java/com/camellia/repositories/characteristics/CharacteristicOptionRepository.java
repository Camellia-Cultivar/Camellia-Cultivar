package com.camellia.repositories.characteristics;

import com.camellia.models.characteristics.CharacteristicValue;

import org.springframework.data.jpa.repository.JpaRepository;
public interface CharacteristicOptionRepository extends JpaRepository<CharacteristicValue, Long>{
    CharacteristicValue findById(long id);
}
