package com.camellia.models.specimens;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.camellia.models.cultivars.Cultivar;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.NoArgsConstructor;


@Entity
@NoArgsConstructor
@Table(name = "reference_specimen")
public class ReferenceSpecimen extends Specimen{
    

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn( referencedColumnName = "cultivar_id", name="cultivar_id", nullable=false)
    @JsonIgnoreProperties("cultivar_id")
    private Cultivar cultivar;


    public Cultivar getCultivar() {
        return this.cultivar;
    }

    public void setCultivar(Cultivar cultivar) {
        this.cultivar = cultivar;
    }


}
