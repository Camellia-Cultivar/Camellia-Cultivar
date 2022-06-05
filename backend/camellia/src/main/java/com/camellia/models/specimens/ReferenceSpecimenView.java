package com.camellia.models.specimens;

import com.camellia.models.cultivars.CultivarView;
import org.springframework.beans.factory.annotation.Value;

import java.util.List;

public interface ReferenceSpecimenView {

    @Value("#{target.specimenId}")
    Long getId();

    String getOwner();

    List<String> getPhotos();

    @Value("#{target.address}")
    String getAddress();

    @Value("#{target.garden}")
    String getGarden();

    CultivarView getCultivar();

    @Value("#{target.latitude}")
    Double getLat();

    @Value("#{target.longitude}")
    Double getLong();
}
