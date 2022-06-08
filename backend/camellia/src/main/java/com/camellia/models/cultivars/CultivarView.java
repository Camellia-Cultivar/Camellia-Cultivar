package com.camellia.models.cultivars;

import com.camellia.models.characteristics.CharacteristicValueDetailsView;
import org.springframework.beans.factory.annotation.Value;

import java.util.List;

public interface CultivarView {

    @Value("#{target.cultivar_id}")
    Long getId();

    String getSpecies();

    String getEpithet();

    List<CharacteristicValueDetailsView> getCharacteristics();
}
