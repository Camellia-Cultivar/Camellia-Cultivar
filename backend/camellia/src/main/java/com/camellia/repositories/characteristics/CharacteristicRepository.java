package com.camellia.repositories.characteristics;

import com.camellia.models.characteristics.Characteristic;

import org.springframework.data.jpa.repository.JpaRepository;

public interface CharacteristicRepository extends JpaRepository<Characteristic, Long>{
    Characteristic findById(long id);
}
