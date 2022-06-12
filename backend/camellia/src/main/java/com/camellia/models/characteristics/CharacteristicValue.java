package com.camellia.models.characteristics;

import java.util.List;
import java.util.Set;

import javax.persistence.*;

import com.camellia.models.cultivars.Cultivar;
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
    @GeneratedValue(
            strategy =  GenerationType.SEQUENCE,
            generator = "characteristic_value_id_generator"
    )
    @SequenceGenerator(
            name = "characteristic_value_id_generator",
            sequenceName = "characteristic_value_id_seq",
            allocationSize = 1
    )
    @JsonProperty("id")
    private Long characteristicValueId;

    @Column( name = "value")
    private Short value;

    @Column( name = "descriptor")
    private String descriptor;
    
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn( referencedColumnName = "characteristic_id", name="characteristic_id", nullable=false)
    @JsonIncludeProperties("id")
    private Characteristic characteristic;

    @ManyToMany(mappedBy = "characteristicValues")
    Set<Specimen> specimens;

    @ManyToMany(mappedBy = "characteristicValues")
    List<Cultivar> cultivars;

    public Long getCharacteristicValueId() {
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

    public void setCharacteristicValueId(Long characteristicValueId) {
        this.characteristicValueId = characteristicValueId;
    }

    public void setValue(Short value) {
        this.value = value;
    }

    public void setDescriptor(String descriptor) {
        this.descriptor = descriptor;
    }

    public void setCharacteristic(Characteristic characteristic) {
        this.characteristic = characteristic;
    }

    public void setSpecimens(Set<Specimen> specimens) {
        this.specimens = specimens;
    }

    public List<Cultivar> getCultivars() {
        return cultivars;
    }

    public void setCultivars(List<Cultivar> cultivars) {
        this.cultivars = cultivars;
    }
}
