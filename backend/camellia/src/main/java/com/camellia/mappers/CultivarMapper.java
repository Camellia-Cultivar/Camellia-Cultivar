package com.camellia.mappers;

import com.camellia.models.cultivars.Cultivar;
import com.camellia.models.cultivars.CultivarDenominationDTO;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Mappings;
import org.mapstruct.factory.Mappers;

@Mapper
public interface CultivarMapper {

    CultivarMapper MAPPER = Mappers.getMapper(CultivarMapper.class );

    @Mappings({
            @Mapping(target = "cultivarId", source = "entity.cultivar_id"),
            @Mapping(target = "denomination", source = "entity.epithet")
    })
    CultivarDenominationDTO cultivarToCultivarDenominationDTO(Cultivar entity);

}
