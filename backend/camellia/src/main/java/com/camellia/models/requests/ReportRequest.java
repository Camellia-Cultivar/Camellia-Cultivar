package com.camellia.models.requests;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.camellia.models.specimens.Specimen;
import com.fasterxml.jackson.annotation.JsonIncludeProperties;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;



// Reports from users due to non camellia related posts


@Entity
@Getter
@Setter
@NoArgsConstructor
@Table(name = "report_request")
public class ReportRequest extends Request{
    

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn( referencedColumnName = "specimen_id", name="specimen_id", nullable=false)
    @JsonIncludeProperties("specimen_id")
    private Specimen to_identify_specimen;


    public Specimen getTo_identify_specimen() {
        return this.to_identify_specimen;
    }

    public void setTo_identify_specimen(Specimen to_identify_specimen) {
        this.to_identify_specimen = to_identify_specimen;
    }


}
