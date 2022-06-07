package com.camellia.models.specimens;

import javax.persistence.AttributeConverter;
import javax.persistence.Converter;
import java.util.Arrays;

@Converter(autoApply = true)
public class SpecimenTypeConverter implements AttributeConverter<SpecimenType, String> {

    @Override
    public String convertToDatabaseColumn(SpecimenType specimenType) {
        if (specimenType == null) {
            return null;
        }
        return specimenType.getCode();
    }

    @Override
    public SpecimenType convertToEntityAttribute(String code) {
        if (code == null) {
            return null;
        }
        return Arrays.stream(SpecimenType.values())
                .filter(t -> t.getCode().equals(code))
                .findFirst()
                .orElseThrow(IllegalArgumentException::new);
    }
}
