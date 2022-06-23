package com.camellia.models.cultivars;

import com.camellia.models.characteristics.CharacteristicValueDetailsView;
import org.springframework.beans.factory.annotation.Value;

import java.util.List;

public interface CultivarView {

    @Value("#{target.id}")
    Long getId();

    String getSpecies();

    String getEpithet();

    @Value("#{target.characteristicValues}")
    List<CharacteristicValueDetailsView> getCharacteristics();
}
