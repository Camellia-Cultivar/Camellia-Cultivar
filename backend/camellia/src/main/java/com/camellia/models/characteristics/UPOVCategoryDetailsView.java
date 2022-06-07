package com.camellia.models.characteristics;

import org.springframework.beans.factory.annotation.Value;

public interface UPOVCategoryDetailsView {

    @Value("#{target.upovCategoryId}")
    public String getId();

    @Value("#{target.name}")
    public String getCategory();
}
