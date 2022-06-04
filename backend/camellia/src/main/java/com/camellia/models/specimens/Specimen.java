package com.camellia.models.specimens;

import java.util.Set;

import javax.persistence.*;

import com.camellia.models.Photo;
import com.camellia.models.QuizAnswer;
import com.camellia.models.characteristics.CharacteristicValue;
import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Getter;

@Entity
@Inheritance(strategy = InheritanceType.TABLE_PER_CLASS)
public abstract class Specimen {
    
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private long specimen_id;

    @Column(name = "owner")
    private String owner;

    // File System link
    @OneToMany(mappedBy = "specimen")
    private Set<Photo> photographs;

    @Column(name = "address", nullable = false)
    private String address;

    @Column(name = "latitude", nullable = false)
    private double latitude;

    @Column(name = "longitude", nullable = false)
    private double longitude;

    @Column(name = "garden")
    private double garden;

    @OneToMany(
        fetch = FetchType.EAGER,
        mappedBy = "specimen",
        cascade = CascadeType.ALL,
        orphanRemoval = true
    )
    @JsonIgnore
    private Set<QuizAnswer> quizAnswers;

    @ManyToMany
    @JoinTable(
        name = "specimen_has_characteristic_values",
        joinColumns = @JoinColumn(name = "specimen_id"),
        inverseJoinColumns = @JoinColumn(name = "characteristic_value_id")
    )
    Set<CharacteristicValue> characteristicValues;



    public String getOwner() {
        return owner;
    }

    public Set<Photo> getPhotographs() {
        return photographs;
    }

    public String getAddress() {
        return address;
    }

    public double getLatitude() {
        return latitude;
    }

    public double getLongitude() {
        return longitude;
    }

    public double getGarden() {
        return garden;
    }

    public Set<QuizAnswer> getQuizzes() {
        return quizAnswers;
    }

    public Set<CharacteristicValue> getCharacteristicValues() {
        return characteristicValues;
    }
}
