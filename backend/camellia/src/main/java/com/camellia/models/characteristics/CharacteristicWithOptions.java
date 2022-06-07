package com.camellia.models.characteristics;

import com.fasterxml.jackson.annotation.JsonProperty;

import javax.persistence.*;
import java.util.Set;

@Entity
@DiscriminatorValue("1")
public class CharacteristicWithOptions extends Characteristic {

    @Override
    @JsonProperty("options")
    public Set<CharacteristicValue> getCharacteristicValues() {
        return super.getCharacteristicValues();
    }
}
