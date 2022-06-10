package com.camellia.mappers.characteristics;

import com.camellia.models.characteristics.CharacteristicValue;
import com.camellia.models.characteristics.CharacteristicValueDTO;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(uses = CharacteristicMapper.class)
public interface CharacteristicValueMapper {

    @Mapping(target = "id", source = "characteristicValue.characteristicValueId")
    CharacteristicValueDTO characteristicValueToCharacteristicValueDTO(CharacteristicValue characteristicValue);

    @Mapping(target = "characteristicValueId", source = "characteristicValueDTO.id")
    CharacteristicValue characteristicValueDTOToCharacteristicValue(CharacteristicValueDTO characteristicValueDTO);
}
