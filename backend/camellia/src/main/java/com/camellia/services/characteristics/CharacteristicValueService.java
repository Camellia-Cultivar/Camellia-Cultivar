package com.camellia.services.characteristics;

import com.camellia.models.characteristics.Characteristic;
import com.camellia.models.characteristics.CharacteristicWithOptions;
import com.camellia.repositories.characteristics.CharacteristicOptionRepository;
import com.camellia.models.characteristics.CharacteristicValue;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Optional;

@Service
public class CharacteristicValueService {
    @Autowired
    private CharacteristicOptionRepository repository;

     @Autowired
     private CharacteristicService characteristicService;

    public Page<CharacteristicValue> getCharacteristicOptions(Pageable pageable) {
        return repository.findAll(pageable);
    }

    public List<CharacteristicValue> getCharacteristicOptions() {
        return repository.findAll();
    }

    public CharacteristicValue getCharacteristicOptionById(long id) {
        return repository.findById(id);
    }

    public CharacteristicValue getOrSaveCharacteristicValue(CharacteristicValue characteristicValue) {
        // fetch and return restricted characteristicValue (persistent in the database)
        Long id = characteristicValue.getCharacteristicValueId();

        Optional<CharacteristicValue> persistentRestrictedCharacteristicValue = getCharacteristicValueById(id);

        return persistentRestrictedCharacteristicValue.orElseGet(() -> getOrSaveUnrestrictedCharacteristicValue(characteristicValue));

    }

    private CharacteristicValue getOrSaveUnrestrictedCharacteristicValue(CharacteristicValue characteristicValue) {
        Characteristic embeddedCharacteristic = characteristicValue.getCharacteristic();

        if(!checkCharacteristicNotNullAndUnrestricted(embeddedCharacteristic))
            return null;

        Optional<CharacteristicValue> persistentCharacteristicValue = Optional.ofNullable(
                repository.findByDescriptorAndCharacteristic(characteristicValue.getDescriptor(), embeddedCharacteristic)
        );

        return persistentCharacteristicValue.orElseGet(() -> repository.save(characteristicValue));
    }

    public Optional<CharacteristicValue> getCharacteristicValueById(Long id) {
        return id != null ? repository.findById(id) : Optional.empty();
    }

    public boolean checkCharacteristicNotNullAndUnrestricted(Characteristic characteristic) {
        if (characteristic == null)
            return false;

        Long characteristicId = characteristic.getCharacteristic_id();
        Optional<Characteristic> persistentCharacteristicOfSameId = characteristicService.getCharacteristicById(characteristicId);

        return persistentCharacteristicOfSameId.isPresent() && !(persistentCharacteristicOfSameId.get() instanceof CharacteristicWithOptions);
    }

}
