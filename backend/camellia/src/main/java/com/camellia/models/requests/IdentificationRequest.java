package com.camellia.models.requests;

import javax.persistence.*;

import com.camellia.models.specimens.Specimen;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Entity
@Getter
@Setter
@NoArgsConstructor
@Table(name = "identification_request")
public class IdentificationRequest extends Request{

    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    @JoinColumn( referencedColumnName = "specimen_id", name="specimen_id", nullable=false)
    @JsonIgnoreProperties("specimen_id")
    private Specimen toIdentifySpecimen;

    public Specimen getToIdentifySpecimen() {
        return toIdentifySpecimen;
    }

    public void setToIdentifySpecimen(Specimen toIdentifySpecimen) {
        this.toIdentifySpecimen = toIdentifySpecimen;
    }

    public void approveRequest() {
        this.getToIdentifySpecimen().approve();
    }
}
