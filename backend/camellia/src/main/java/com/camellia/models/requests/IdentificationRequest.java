package com.camellia.models.requests;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.camellia.models.Quiz;
import com.camellia.models.specimens.ToIdentifySpecimen;
import com.fasterxml.jackson.annotation.JsonIncludeProperties;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Entity
@Getter
@Setter
@NoArgsConstructor
@Table(name = "identification_request")
public class IdentificationRequest extends Request{

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "quiz_id", referencedColumnName = "quiz_id")
    private Quiz quiz;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn( referencedColumnName = "specimen_id", name="specimen_id", nullable=false)
    @JsonIncludeProperties("specimen_id")
    private ToIdentifySpecimen to_identify_specimen;
}
