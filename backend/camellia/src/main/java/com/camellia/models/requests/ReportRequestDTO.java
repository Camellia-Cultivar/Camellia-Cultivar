package com.camellia.models.requests;

import java.time.LocalDateTime;

public class ReportRequestDTO {
    private LocalDateTime submissionDate;

    

    private long regId;

    private long specimenId;

    public ReportRequestDTO(){}

    public ReportRequestDTO(ReportRequest cr){
        this.submissionDate = cr.getSubmissionDate();
        this.regId = cr.getRegId();
        this.specimenId = cr.getTo_identify_specimen().getSpecimenId();
    }



    public LocalDateTime getSubmissionDate() {
        return this.submissionDate;
    }

    public void setSubmissionDate(LocalDateTime submissionDate) {
        this.submissionDate = submissionDate;
    }

    public long getSpecimenId() {
        return this.specimenId;
    }

    public void setSpecimenId(long specimenId) {
        this.specimenId = specimenId;
    }
    

    public long getRegId() {
        return this.regId;
    }

    public void setRegId(long regId) {
        this.regId = regId;
    }
}
