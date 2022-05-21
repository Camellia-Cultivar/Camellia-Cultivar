package com.camellia.mappers;

import com.camellia.models.cultivars.CultivarDenominationDTO;
import com.camellia.models.cultivars.CultivarSynonyms;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Mappings;
import org.mapstruct.factory.Mappers;

@Mapper
public interface CultivarSynonymMapper {

    CultivarSynonymMapper MAPPER = Mappers.getMapper(CultivarSynonymMapper.class );

    @Mappings({
            @Mapping(target = "cultivarId", source = "entity.cultivar.cultivar_id"),
            @Mapping(target = "denomination", source = "entity.synonym")
    })
    CultivarDenominationDTO synonymToCultivarDenominationDTO(CultivarSynonyms entity);

}
