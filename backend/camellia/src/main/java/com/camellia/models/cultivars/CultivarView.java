package com.camellia.models.cultivars;

import org.springframework.beans.factory.annotation.Value;

public interface CultivarView {

    @Value("#{target.cultivar_id}")
    Long getId();

    String getSpecies();

    String getEpithet();
}
