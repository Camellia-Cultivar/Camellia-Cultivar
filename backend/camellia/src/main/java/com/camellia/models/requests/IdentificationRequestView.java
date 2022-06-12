package com.camellia.models.requests;

import org.springframework.beans.factory.annotation.Value;

import java.time.LocalDateTime;
import java.util.Map;

public interface IdentificationRequestView {

    @Value(value = "#{target.submissionDate}")
    public LocalDateTime getSubmission();

    @Value(value = "#{target.toIdentifySpecimen.cultivarProbabilities}")
    public Map<String, Double> getCultivarProbabilities();

    @Value(value = "#{target.toIdentifySpecimen.address}")
    public String getAddress();

    @Value(value = "#{target.toIdentifySpecimen.garden}")
    public String getGarden();
}
