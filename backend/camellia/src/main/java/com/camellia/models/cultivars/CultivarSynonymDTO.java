package com.camellia.models.cultivars;

public class CultivarSynonymDTO {

    private long cultivar_synonym_id;

    private String synonym;

    private String cultivarEpithet;

    public CultivarSynonymDTO(){

    }


    public long getCultivar_synonym_id() {
        return this.cultivar_synonym_id;
    }

    public void setCultivar_synonym_id(long cultivar_synonym_id) {
        this.cultivar_synonym_id = cultivar_synonym_id;
    }

    public String getSynonym() {
        return this.synonym;
    }

    public void setSynonym(String synonym) {
        this.synonym = synonym;
    }

    public String getCultivarEpithet() {
        return this.cultivarEpithet;
    }

    public void setCultivarEpithet(String cultivarEpithet) {
        this.cultivarEpithet = cultivarEpithet;
    }
}
