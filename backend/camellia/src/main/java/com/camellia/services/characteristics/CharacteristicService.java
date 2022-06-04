package com.camellia.services.characteristics;

import com.camellia.repositories.characteristics.CharacteristicRepository;
import com.camellia.models.characteristics.Characteristic;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Optional;

@Service
public class CharacteristicService {
    @Autowired
    private CharacteristicRepository repository;

    public Page<Characteristic> getCharacteristics(Pageable pageable) {
        return repository.findAll(pageable);
    }

    public List<Characteristic> getCharacteristics() {
        return repository.findAll();
    }

    public Optional<Characteristic> getCharacteristicById(Long id) {
        return repository.findById(id);
    }
}
