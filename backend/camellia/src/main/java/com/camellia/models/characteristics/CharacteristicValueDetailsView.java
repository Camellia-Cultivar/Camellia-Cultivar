package com.camellia.models.characteristics;

import org.springframework.beans.factory.annotation.Value;

public interface CharacteristicValueDetailsView {
    @Value("#{target.characteristicValueId}")
    Long getId();


    @Value("#{target.characteristic}")
    CharacteristicDetailsView getCharacteristic();
}
