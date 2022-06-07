package com.camellia.models.cultivars;


import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;


import com.camellia.models.characteristics.CharacteristicValue;
import com.camellia.models.specimens.Specimen;
import lombok.Data;

@Data
public class CultivarDTO {


    private Long id;

    private String species;

    private String epithet;

    private String description;

    private String photograph;


    private Set<CultivarSynonyms> synonyms;

    private List<CharacteristicValue> characteristicValues;

    private Map<Specimen, Integer> cultivarVotes = new HashMap<>();

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getSpecies() {
        return species;
    }

    public void setSpecies(String species) {
        this.species = species;
    }

    public String getEpithet() {
        return epithet;
    }

    public void setEpithet(String epithet) {
        this.epithet = epithet;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }


    public String getPhotograph() {
        return this.photograph;
    }

    public void setPhotograph(String photo) {
        this.photograph = photo;
    }

    public Set<CultivarSynonyms> getSynonyms() {
        return this.synonyms;
    }

    public void setSynonyms(Set<CultivarSynonyms> synonyms) {
        this.synonyms = synonyms;
    }

    public Map<Specimen,Integer> getCultivarVotes() {
        return this.cultivarVotes;
    }

    public void setCultivarVotes(Map<Specimen,Integer> cultivarVotes) {
        this.cultivarVotes = cultivarVotes;
    }

    public List<CharacteristicValue> getCharacteristicValues() {
        return characteristicValues;
    }

    public void setCharacteristicValues(List<CharacteristicValue> characteristicValues) {
        this.characteristicValues = characteristicValues;
    }
}

