package com.camellia.models.requests;

import javax.persistence.*;

import com.camellia.models.specimens.ToIdentifySpecimen;
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
    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn( referencedColumnName = "specimen_id", name="specimen_id", nullable=false)
    @JsonIgnoreProperties("specimen_id")
    private ToIdentifySpecimen toIdentifySpecimen;
}
