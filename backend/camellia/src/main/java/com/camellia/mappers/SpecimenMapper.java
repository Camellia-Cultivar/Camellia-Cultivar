package com.camellia.mappers;

import com.camellia.models.specimens.*;
import org.mapstruct.Mapper;

@Mapper
public interface SpecimenMapper {

    SpecimenDto specimenToSpecimenDTO(Specimen specimen);

    ReferenceSpecimen specimenDTOToReferenceSpecimen(SpecimenDto specimenDto);

    ToIdentifySpecimen specimenDTOtoToIdentifySpecimen(SpecimenDto specimenDto);
}
