package com.camellia.models.characteristics;

import org.springframework.beans.factory.annotation.Value;

import java.util.Set;

public interface UPOVCategoryView {

    @Value("#{target.upovCategoryId}")
    public String getId();

    @Value("#{target.name}")
    public String getCategory();

    public Set<Characteristic> getCharacteristics();
}
