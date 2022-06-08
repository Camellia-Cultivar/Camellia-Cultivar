package com.camellia.models.requests;

import com.camellia.models.specimens.SpecimenDto;
import com.camellia.models.users.UserDTO;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;


public class IdentificationRequestDTO {
    private long requestId;
    private LocalDateTime submissionDate;
    private UserDTO submitter;
    private SpecimenDto toIdentifySpecimen;

    public long getRequestId() {
        return requestId;
    }

    public void setRequestId(long requestId) {
        this.requestId = requestId;
    }

    public LocalDateTime getSubmissionDate() {
        return submissionDate;
    }

    public void setSubmissionDate(LocalDateTime submissionDate) {
        this.submissionDate = submissionDate;
    }

    public UserDTO getSubmitter() {
        return submitter;
    }

    public void setSubmitter(UserDTO submitter) {
        this.submitter = submitter;
    }

    public SpecimenDto getToIdentifySpecimen() {
        return toIdentifySpecimen;
    }

    public void setToIdentifySpecimen(SpecimenDto toIdentifySpecimen) {
        this.toIdentifySpecimen = toIdentifySpecimen;
    }
}
