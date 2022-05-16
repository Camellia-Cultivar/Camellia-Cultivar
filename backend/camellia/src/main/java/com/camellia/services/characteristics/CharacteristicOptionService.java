package com.camellia.services.characteristics;

import com.camellia.repositories.characteristics.CharacteristicOptionRepository;
import com.camellia.models.characteristics.CharacteristicOption;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

@Service
public class CharacteristicOptionService {
    @Autowired
    private CharacteristicOptionRepository repository;

    public Page<CharacteristicOption> getCharacteristicOptions(Pageable pageable) {
        return repository.findAll(pageable);
    }

    public List<CharacteristicOption> getCharacteristicOptions() {
        return repository.findAll();
    }

    public CharacteristicOption getCharacteristicOptionById(long id) {
        return repository.findById((long) id);
    }
}
