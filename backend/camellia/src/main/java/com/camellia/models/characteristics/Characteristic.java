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
    @JsonProperty("id")
    private long characteristic_id;

    @Column(name = "name")
    private String name;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn( referencedColumnName = "upov_category_id", name="upov_category_id", nullable=false)
    @JsonIgnore
    private UPOVCategory upov_category;


    @OneToMany(
            fetch = FetchType.EAGER,
            mappedBy = "characteristic",
            cascade = CascadeType.ALL,
            orphanRemoval = true
    )
    @JsonIgnoreProperties({ "specimens" })
    private Set<CharacteristicValue> characteristic_values;

    @JsonProperty("values")
    public Set<CharacteristicValue> getCharacteristic_values() {
        return characteristic_values;
    }

    public long getCharacteristic_id() {
        return characteristic_id;
    }

    public String getName() {
        return name;
    }

    public UPOVCategory getUpov_category() {
        return upov_category;
    }
}
