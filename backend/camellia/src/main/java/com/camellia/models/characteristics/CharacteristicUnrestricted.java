package com.camellia.models.characteristics;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;

@Entity
@DiscriminatorValue("0")
@JsonIgnoreProperties(value = {"values"})
public class CharacteristicUnrestricted extends Characteristic {

}
