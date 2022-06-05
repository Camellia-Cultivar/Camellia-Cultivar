package com.camellia.models.specimens;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import javax.persistence.*;

import com.camellia.models.QuizAnswer;
import com.camellia.models.cultivars.Cultivar;
import com.camellia.models.requests.IdentificationRequest;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.NoArgsConstructor;

@Entity
@NoArgsConstructor
@Table( name = "to_identify_specimen")
public class ToIdentifySpecimen extends Specimen{
    

    @OneToOne(
        fetch = FetchType.LAZY,
        mappedBy = "toIdentifySpecimen",
        cascade = CascadeType.ALL,
        orphanRemoval = true
    )
    @JsonIgnoreProperties("toIdentifySpecimen")
    private IdentificationRequest identificationRequest;


    @OneToMany(
            fetch = FetchType.LAZY,
            mappedBy = "specimen",
            cascade = CascadeType.ALL,
            orphanRemoval = true
    )
    @JsonIgnoreProperties("specimen")
    private Set<QuizAnswer> quizAnswers;

    @ElementCollection
    @CollectionTable(name = "specimen_might_be",
            joinColumns = @JoinColumn(name = "specimen_id")
    )
    @MapKeyJoinColumn(name = "cultivar_id")
    @JsonIgnore
    private Map<Cultivar, Float> cultivarProbabilities = new HashMap<>();

    public Map<Cultivar, Float> getCultivarProbabilities() {
        return cultivarProbabilities;
    }

    public void setCultivarProbabilities(Map<Cultivar, Float> cultivarProbabilities) {
        this.cultivarProbabilities = cultivarProbabilities;
    }


    public IdentificationRequest getIdentificationRequest() {
        return this.identificationRequest;
    }

    public void setIdentificationRequest(IdentificationRequest identificationRequest) {
        this.identificationRequest = identificationRequest;
    }
}
