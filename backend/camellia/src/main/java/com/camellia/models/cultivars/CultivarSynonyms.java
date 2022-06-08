package com.camellia.models.cultivars;

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
    @Column(name = "cultivar_synonym_id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long cultivarSynonymId;

    @Column(name = "synonym")
    private String synonym;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn( referencedColumnName = "cultivar_id", name="cultivar_id", nullable=false)
    @JsonIncludeProperties("cultivar_id")
    private Cultivar cultivar;

    public long getCultivarSynonymId() {
        return cultivarSynonymId;
    }

    public void setCultivarSynonymSd(long cultivarSynonymId) {
        this.cultivarSynonymId = cultivarSynonymId;
    }

    public String getSynonym() {
        return synonym;
    }

    public void setSynonym(String synonym) {
        this.synonym = synonym;
    }

    public Cultivar getCultivar() {
        return cultivar;
    }

    public void setCultivar(Cultivar cultivar) {
        this.cultivar = cultivar;
    }
}
