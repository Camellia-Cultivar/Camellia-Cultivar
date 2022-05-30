package com.camellia.models.cultivars;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.CollectionTable;
import javax.persistence.Column;
import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.MapKeyJoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.JoinColumn;

import com.camellia.models.QuizAnswer;
import com.camellia.models.specimens.ReferenceSpecimen;
import com.camellia.models.specimens.ToIdentifySpecimen;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.NoArgsConstructor;

@Entity
@NoArgsConstructor
@Table(name = "cultivar")
public class Cultivar {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY )
    private long cultivar_id;

    @Column(name = "species")
    private String species;

    @Column(name = "epithet")
    private String epithet;

    @Column(name = "description", columnDefinition="TEXT")
    private String description;

    @Column(name = "photograph")
    private String photograph;

    @OneToMany(
        fetch = FetchType.EAGER,
        mappedBy = "cultivar",
        cascade = CascadeType.ALL,
        orphanRemoval = true
    )
    @JsonIgnoreProperties("cultivar")
    private Set<ReferenceSpecimen> referenceSpecimens;

    @OneToMany(
        fetch = FetchType.EAGER,
        mappedBy = "cultivar",
        cascade = CascadeType.ALL,
        orphanRemoval = true
    )
    @JsonIgnoreProperties("cultivar")
    private Set<QuizAnswer> quizAnswers;


    @OneToMany(
        fetch = FetchType.EAGER,
        mappedBy = "cultivar",
        cascade = CascadeType.ALL,
        orphanRemoval = true
    )
    @JsonIgnoreProperties("cultivar")
    private Set<CultivarSynonyms> synonyms;


    @ElementCollection
    @CollectionTable(name = "specimen_might_be",
            joinColumns = @JoinColumn(name = "cultivar_id")
    )
    @MapKeyJoinColumn(name = "specimen_id")
    private Map<ToIdentifySpecimen, Integer> cultivar_votes = new HashMap<>();



    public long getCultivar_id() {
        return cultivar_id;
    }

    public void setCultivar_id(long cultivar_id) {
        this.cultivar_id = cultivar_id;
    }

    public String getSpecies() {
        return species;
    }

    public void setSpecies(String species) {
        this.species = species;
    }

    public String getEpithet() {
        return epithet;
    }

    public void setEpithet(String epithet) {
        this.epithet = epithet;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }


    public String getPhotograph() {
        return this.photograph;
    }

    public void setPhotograph(String photo) {
        this.photograph = photo;
    }

    public Set<ReferenceSpecimen> getReferenceSpecimens() {
        return this.referenceSpecimens;
    }

    public void setReferenceSpecimens(Set<ReferenceSpecimen> referenceSpecimens) {
        this.referenceSpecimens = referenceSpecimens;
    }

    public Set<Quiz> getQuizzes() {
        return this.quizzes;
    }

    public void setQuizzes(Set<Quiz> quizzes) {
        this.quizzes = quizzes;
    }

    public Set<CultivarSynonyms> getSynonyms() {
        return this.synonyms;
    }

    public void setSynonyms(Set<CultivarSynonyms> synonyms) {
        this.synonyms = synonyms;
    }

    public Map<ToIdentifySpecimen,Integer> getCultivar_votes() {
        return this.cultivar_votes;
    }

    public void setCultivar_votes(Map<ToIdentifySpecimen,Integer> cultivar_votes) {
        this.cultivar_votes = cultivar_votes;
    }


    
}
