package com.camellia.models.specimens;

import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.Map;
import java.util.Set;

import javax.persistence.*;

import com.camellia.models.QuizAnswer;
import com.camellia.models.characteristics.CharacteristicValue;
import com.camellia.models.cultivars.Cultivar;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import org.hibernate.annotations.Cascade;

@Entity
@Table(name = "specimen")
public class Specimen {
    
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    @Column(name = "specimen_id")
    private long specimenId;

    @Column(name = "owner")
    private String owner;


    @Column(name = "address", nullable = false)
    private String address;

    @Column(name = "latitude", nullable = false)
    private double latitude;

    @Column(name = "longitude", nullable = false)
    private double longitude;

    @Column(name = "garden")
    private String garden;

    @Column(name = "specimen_type", length = 16, columnDefinition = "VARCHAR(16) default 'FOR_APPROVAL'")
    @Enumerated(value = EnumType.STRING)
    private SpecimenType specimenType;


    @OneToMany(
        fetch = FetchType.EAGER,
        mappedBy = "specimen",
        cascade = CascadeType.ALL,
        orphanRemoval = true
    )
    @JsonIgnoreProperties("specimen")
    private Set<QuizAnswer> quizAnswers;

    @ManyToMany
    @Cascade(org.hibernate.annotations.CascadeType.SAVE_UPDATE)
    @JoinTable(
        name = "specimen_has_characteristic_values",
        joinColumns = @JoinColumn(name = "specimen_id"),
        inverseJoinColumns = @JoinColumn(name = "characteristic_value_id")
    )
    @JsonIgnore
    Set<CharacteristicValue> characteristicValues;

    @ElementCollection
    @Column(name = "photo")
    @CollectionTable(name = "specimen_photos", joinColumns = @JoinColumn(name = "specimen_id"))
    private Set<String> photos = new LinkedHashSet<>();

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn( referencedColumnName = "cultivar_id", name="cultivar_id")
    @JsonIgnoreProperties("specimens")
    private Cultivar cultivar;

    @ElementCollection
    @CollectionTable(name = "specimen_might_be",
            joinColumns = @JoinColumn(name = "specimen_id")
    )
    @MapKeyJoinColumn(name = "cultivar_id")
    @JsonIgnore
    private Map<Cultivar, Float> cultivarProbabilities = new HashMap<>();


    public Cultivar getCultivar() {
        return cultivar;
    }

    public void setCultivar(Cultivar cultivar) {
        this.cultivar = cultivar;
    }

    public Map<Cultivar, Float> getCultivarProbabilities() {
        return cultivarProbabilities;
    }

    public void setCultivarProbabilities(Map<Cultivar, Float> cultivarProbabilities) {
        this.cultivarProbabilities = cultivarProbabilities;
    }

    public long getSpecimenId() {
        return specimenId;
    }

    public void setSpecimenId(long specimenId) {
        this.specimenId = specimenId;
    }

    public String getOwner() {
        return owner;
    }

    public void setOwner(String owner) {
        this.owner = owner;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }

    public String getGarden() {
        return garden;
    }

    public void setGarden(String garden) {
        this.garden = garden;
    }

    public SpecimenType getSpecimenType() {
        return specimenType;
    }

    public void setSpecimenType(SpecimenType specimenType) {
        this.specimenType = specimenType;
    }

    public Set<CharacteristicValue> getCharacteristicValues() {
        return characteristicValues;
    }

    public void setCharacteristicValues(Set<CharacteristicValue> characteristicValues) {
        this.characteristicValues = characteristicValues;
    }

    public Set<String> getPhotos() {
        return photos;
    }

    public void setPhotos(Set<String> photos) {
        this.photos = photos;
    }
    public boolean isReference() {
        return specimenType.equals(SpecimenType.REFERENCE);
    }

    public boolean isToIdentify() {
        return specimenType.equals(SpecimenType.TO_IDENTIFY);
    }

    public boolean needsModeratorApproval() {
        return specimenType.equals(SpecimenType.FOR_APPROVAL);
    }
}
