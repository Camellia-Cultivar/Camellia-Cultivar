package com.camellia.models;

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

import com.camellia.models.specimens.ReferenceSpecimen;
import com.camellia.models.specimens.ToIdentifySpecimen;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Getter
@Setter
@NoArgsConstructor
@Table(name = "cultivar")
public class Cultivar {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY )
    private long cultivar_id;

    @Column(name = "species")
    private String specie;

    @Column(name = "epithet")
    private String epithet;

    @Column(name = "description", columnDefinition="TEXT")
    private String description;

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
    private Set<Quiz> quizzes;


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
}
