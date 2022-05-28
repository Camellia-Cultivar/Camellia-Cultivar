package com.camellia.services.characteristics;

import com.camellia.repositories.characteristics.CharacteristicOptionRepository;
import com.camellia.models.characteristics.CharacteristicValue;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

@Service
public class CharacteristicOptionService {
    @Autowired
    private CharacteristicOptionRepository repository;

    public Page<CharacteristicValue> getCharacteristicOptions(Pageable pageable) {
        return repository.findAll(pageable);
    }

    public List<CharacteristicValue> getCharacteristicOptions() {
        return repository.findAll();
    }

    public CharacteristicValue getCharacteristicOptionById(long id) {
        return repository.findById((long) id);
    }
}
