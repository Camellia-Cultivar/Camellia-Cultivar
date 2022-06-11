package com.camellia.mappers.characteristics;

import com.camellia.models.characteristics.Characteristic;
import com.camellia.models.characteristics.CharacteristicDTO;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(uses = UPOVCategoryMapper.class)
public interface CharacteristicMapper {

    @Mapping(target = "id", source = "characteristic.characteristicId")
    CharacteristicDTO characteristicToCharacteristicDTO(Characteristic characteristic);

    @Mapping(target = "characteristicId", source = "characteristicDTO.id")
    Characteristic characteristicDTOToCharacteristic(CharacteristicDTO characteristicDTO);
}
