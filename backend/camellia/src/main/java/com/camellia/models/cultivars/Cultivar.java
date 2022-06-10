package com.camellia.models.cultivars;

import com.camellia.models.QuizAnswer;
import com.camellia.models.characteristics.CharacteristicValue;
import com.camellia.models.specimens.Specimen;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonManagedReference;

import javax.persistence.*;
import java.util.List;
import java.util.Set;

@Entity
@Table(name = "cultivar")
public class Cultivar {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO )
    @Column(name = "cultivar_id")
    private Long id;

    @Column(name = "species")
    private String species;

    @Column(name = "epithet")
    private String epithet;

    @Column(name = "photograph")
    private String photograph;

    @OneToMany(
            mappedBy = "cultivar"
    )
    @JsonIgnoreProperties("cultivar")
    private List<Specimen> specimens;

    @OneToMany(
            mappedBy = "cultivar"
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

    @ManyToMany
    @JoinTable(
            name = "cultivar_characteristic_values",
            joinColumns = @JoinColumn(name = "cultivar_id"),
            inverseJoinColumns = @JoinColumn(name = "characteristic_value_id"))
    @JsonIgnoreProperties("specimens")
    private List<CharacteristicValue> characteristicValues;

    @Column(name = "description", columnDefinition="TEXT")
    private String description;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
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

    public String getPhotograph() {
        return photograph;
    }

    public void setPhotograph(String photograph) {
        this.photograph = photograph;
    }

    public List<Specimen> getSpecimens() {
        return specimens;
    }

    public void setSpecimens(List<Specimen> specimens) {
        this.specimens = specimens;
    }

    public Set<QuizAnswer> getQuizAnswers() {
        return quizAnswers;
    }

    public void setQuizAnswers(Set<QuizAnswer> quizAnswers) {
        this.quizAnswers = quizAnswers;
    }

    public Set<CultivarSynonyms> getSynonyms() {
        return synonyms;
    }

    public void setSynonyms(Set<CultivarSynonyms> synonyms) {
        this.synonyms = synonyms;
    }
    
    public List<CharacteristicValue> getCharacteristicValues() {
        return characteristicValues;
    }

    public void setCharacteristicValues(List<CharacteristicValue> characteristics) {
        this.characteristicValues = characteristics;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }


}