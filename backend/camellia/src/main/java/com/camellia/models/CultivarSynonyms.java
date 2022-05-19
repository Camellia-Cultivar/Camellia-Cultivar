package com.camellia.models;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIncludeProperties;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Getter
@Setter
@NoArgsConstructor
@Table(name = "cultivar_synonyms")
public class CultivarSynonyms {
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long cultivar_synonym_id;

    @Column(name = "synonym")
    private String synonym;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn( referencedColumnName = "cultivar_id", name="cultivar_id", nullable=false)
    @JsonIncludeProperties("cultivar_id")
    private Cultivar cultivar;
}
