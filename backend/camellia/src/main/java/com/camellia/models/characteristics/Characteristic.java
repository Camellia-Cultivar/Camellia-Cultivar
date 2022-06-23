package com.camellia.models.characteristics;

import java.util.Set;

import javax.persistence.*;

import com.fasterxml.jackson.annotation.*;

@Entity
@Table(name = "characteristic")
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name = "has_options", discriminatorType = DiscriminatorType.INTEGER)
public class Characteristic {

    @Id
    @GeneratedValue(strategy =  GenerationType.AUTO)
    @Column(name = "characteristic_id")
    @JsonProperty("id")
    private Long characteristicId;

    @Column(name = "name")
    private String name;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn( referencedColumnName = "upov_category_id", name="upov_category_id", nullable=false)
    @JsonIgnore
    private UPOVCategory upovCategory;


    @OneToMany(
            fetch = FetchType.EAGER,
            mappedBy = "characteristic",
            cascade = CascadeType.ALL,
            orphanRemoval = true
    )
    @JsonIgnoreProperties({ "specimens", "cultivars" })
    private Set<CharacteristicValue> characteristicValues;

    @JsonProperty("values")
    public Set<CharacteristicValue> getCharacteristicValues() {
        return characteristicValues;
    }

    public Long getCharacteristicId() {
        return characteristicId;
    }

    public String getName() {
        return name;
    }

    public UPOVCategory getUpovCategory() {
        return upovCategory;
    }

    public void setCharacteristicId(Long characteristicId) {
        this.characteristicId = characteristicId;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setUpovCategory(UPOVCategory upovCategory) {
        this.upovCategory = upovCategory;
    }

    public void setCharacteristicValues(Set<CharacteristicValue> characteristicValues) {
        this.characteristicValues = characteristicValues;
    }
}
