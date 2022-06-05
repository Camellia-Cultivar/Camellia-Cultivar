package com.camellia.models.specimens;

import com.camellia.models.characteristics.CharacteristicValue;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import java.util.Set;

public class SpecimenDto {
    private long specimenId;
    private String owner;

    private Set<String> photos;
    private String address;
    private double latitude;
    private double longitude;
    private String garden;
    @JsonIgnoreProperties("specimens")
    private Set<CharacteristicValue> characteristicValues;


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

    public Set<String> getPhotos() {
        return photos;
    }

    public void setPhotos(Set<String> photos) {
        this.photos = photos;
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

    public Set<CharacteristicValue> getCharacteristicValues() {
        return characteristicValues;
    }

    public void setCharacteristicValues(Set<CharacteristicValue> characteristicValues) {
        this.characteristicValues = characteristicValues;
    }
}
