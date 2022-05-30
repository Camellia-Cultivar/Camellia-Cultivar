package com.camellia.models.cultivars;


import java.util.HashMap;
import java.util.Map;
import java.util.Set;


import com.camellia.models.specimens.ToIdentifySpecimen;


public class CultivarDTO {


    private long cultivar_id;

    private String species;

    private String epithet;

    private String description;

    private String photograph;


    private Set<CultivarSynonyms> synonyms;


    private Map<ToIdentifySpecimen, Integer> cultivar_votes = new HashMap<>();

    public CultivarDTO(){
    }

    public CultivarDTO(Cultivar c){
        this.cultivar_id = c.getCultivar_id();
        this.species = c.getSpecies();
        this.epithet = c.getEpithet();
        this.description = c.getDescription();
        this.photograph = c.getPhotograph();
        this.synonyms = c.getSynonyms();
        this.cultivar_votes = c.getCultivar_votes();
    }

    public long getCultivar_id() {
        return cultivar_id;
    }

    public void setCultivar_id(long cultivar_id) {
        this.cultivar_id = cultivar_id;
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

    public Map<ToIdentifySpecimen,Integer> getCultivar_votes() {
        return this.cultivar_votes;
    }

    public void setCultivar_votes(Map<ToIdentifySpecimen,Integer> cultivar_votes) {
        this.cultivar_votes = cultivar_votes;
    }


    
}

