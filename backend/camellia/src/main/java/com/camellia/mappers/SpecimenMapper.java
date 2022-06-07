package com.camellia.mappers;

import com.camellia.models.specimens.*;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

@Mapper
public interface SpecimenMapper {

    SpecimenMapper MAPPER = Mappers.getMapper(SpecimenMapper.class );

    SpecimenDto specimenToSpecimenDTO(Specimen specimen);

    @Mapping(target = "specimenType", constant = "REFERENCE")
    Specimen specimenDTOToReferenceSpecimen(SpecimenDto specimenDto);

    @Mapping(target = "specimenType", constant = "TO_IDENTIFY")
    Specimen specimenDTOtoToIdentifySpecimen(SpecimenDto specimenDto);
}
