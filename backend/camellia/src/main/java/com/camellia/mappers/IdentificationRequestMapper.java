package com.camellia.mappers;

import com.camellia.models.requests.IdentificationRequest;
import com.camellia.models.requests.IdentificationRequestDTO;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

@Mapper(uses = UserMapper.class)
public interface IdentificationRequestMapper {

    IdentificationRequestMapper MAPPER = Mappers.getMapper(IdentificationRequestMapper.class);

    @Mapping(target = "request_id", source = "requestId")
    @Mapping(target = "regUser", source = "submitter")
    IdentificationRequest identificationRequestDTOToIdentificationRequest(IdentificationRequestDTO dto);


    @Mapping(target = "requestId", source = "request_id")
    @Mapping(target = "submitter", source = "regUser")
    IdentificationRequestDTO identificationRequestToIdentificationRequestDTO(IdentificationRequest request);
}
