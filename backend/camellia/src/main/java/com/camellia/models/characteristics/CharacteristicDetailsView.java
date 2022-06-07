package com.camellia.models.characteristics;

import org.springframework.beans.factory.annotation.Value;

public interface CharacteristicDetailsView {
    @Value("#{target.characteristic_id}")
    Long getId();
}
