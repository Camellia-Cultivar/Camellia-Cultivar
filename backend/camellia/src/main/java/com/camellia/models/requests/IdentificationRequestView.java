package com.camellia.models.requests;

import org.springframework.beans.factory.annotation.Value;

import java.time.LocalDateTime;
import java.util.Map;

public interface IdentificationRequestView {

    @Value(value = "#{target.submissionDate}")
    LocalDateTime getSubmission();

    @Value(value = "#{target.toIdentifySpecimen.cultivarProbabilities}")
    Map<String, Double> getCultivarProbabilities();

    @Value(value = "#{target.toIdentifySpecimen.address}")
    String getAddress();

    @Value(value = "#{target.toIdentifySpecimen.getFirstPhoto()}")
    String getPhoto();

    @Value(value = "#{target.toIdentifySpecimen.garden}")
    String getGarden();
}
