package com.camellia.mappers.characteristics;

import com.camellia.models.characteristics.UPOVCategory;
import com.camellia.models.characteristics.UPOVCategoryDTO;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper
public interface UPOVCategoryMapper {

    @Mapping(target = "id", source = "category.upovCategoryId")
    UPOVCategoryDTO upovCategoryToUPOVCategoryDTO(UPOVCategory category);

    @Mapping(target = "upovCategoryId", source = "categoryDTO.id")
    UPOVCategory upovCategoryDTOToUPOVCategory(UPOVCategoryDTO categoryDTO);
}
