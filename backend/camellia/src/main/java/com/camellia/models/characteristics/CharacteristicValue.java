package com.camellia.models.characteristics;

import java.util.Set;

import javax.persistence.*;

import com.camellia.models.specimens.Specimen;
import com.fasterxml.jackson.annotation.JsonIncludeProperties;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Getter
@Setter
@NoArgsConstructor
@Table(name = "characteristic_value")
public class CharacteristicValue {

    @Id
    @GeneratedValue( strategy =  GenerationType.AUTO)
    @JsonProperty("id")
    private long characteristicValueId;

    @Column( name = "value")
    private Short value;

    @Column( name = "descriptor")
    private String descriptor;
    
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn( referencedColumnName = "characteristic_id", name="characteristic_id", nullable=false)
    @JsonIncludeProperties("characteristic_id")
    private Characteristic characteristic;

    @ManyToMany(mappedBy = "characteristicValues")
    Set<Specimen> specimens;

    public long getCharacteristicValueId() {
        return characteristicValueId;
    }

    public Short getValue() {
        return value;
    }

    public String getDescriptor() {
        return descriptor;
    }

    public Characteristic getCharacteristic() {
        return characteristic;
    }

    public Set<Specimen> getSpecimens() {
        return specimens;
    }
}
