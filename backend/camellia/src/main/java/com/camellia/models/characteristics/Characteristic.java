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
    private long characteristicId;

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
    @JsonIgnoreProperties({ "specimens" })
    private Set<CharacteristicValue> characteristicValues;

    @JsonProperty("values")
    public Set<CharacteristicValue> getCharacteristicValues() {
        return characteristicValues;
    }

    public long getCharacteristicId() {
        return characteristicId;
    }

    public String getName() {
        return name;
    }

    public UPOVCategory getUpovCategory() {
        return upovCategory;
    }
}
