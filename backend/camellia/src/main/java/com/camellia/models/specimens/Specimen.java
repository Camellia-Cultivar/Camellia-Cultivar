package com.camellia.models.specimens;

import java.util.Set;

import javax.persistence.*;

import com.camellia.models.Photo;
import com.camellia.models.QuizAnswer;
import com.camellia.models.characteristics.CharacteristicValue;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.NoArgsConstructor;

@Entity
@NoArgsConstructor
@Inheritance(strategy = InheritanceType.TABLE_PER_CLASS)
public abstract class Specimen {
    
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private long specimen_id;

    @Column(name = "owner")
    private String owner;

    // File System link
    @OneToMany(mappedBy = "specimen")
    @JsonIgnore
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
    @JsonIgnoreProperties("specimen")
    private Set<QuizAnswer> quizAnswers;

    @ManyToMany
    @JoinTable(
        name = "specimen_has_characteristic_values",
        joinColumns = @JoinColumn(name = "specimen_id"),
        inverseJoinColumns = @JoinColumn(name = "characteristic_value_id")
    )
    @JsonIgnore
    Set<CharacteristicValue> characteristicValues;


    public long getSpecimen_id() {
        return this.specimen_id;
    }

    public void setSpecimen_id(long specimen_id) {
        this.specimen_id = specimen_id;
    }

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

    public void setOwner(String owner) {
        this.owner = owner;
    }
    public void setPhotographs(Set<Photo> photographs) {
        this.photographs = photographs;
    }
    public void setAddress(String address) {
        this.address = address;
    }
    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }
    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }
    public void setGarden(double garden) {
        this.garden = garden;
    }

    public Set<QuizAnswer> getQuizAnswers() {
        return this.quizAnswers;
    }

    public void setQuizAnswers(Set<QuizAnswer> quizAnswers) {
        this.quizAnswers = quizAnswers;
    }
    public void setCharacteristicValues(Set<CharacteristicValue> characteristicValues) {
        this.characteristicValues = characteristicValues;
    }

}
