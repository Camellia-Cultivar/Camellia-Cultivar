package com.camellia.models.requests;

public class CultivarRequestDTO {
    
    private String suggestion;

    private String icr_link;
    
    public CultivarRequestDTO(){}


    public String getSuggestion() {
        return this.suggestion;
    }

    public void setSuggestion(String suggestion) {
        this.suggestion = suggestion;
    }

    public String getIcr_link() {
        return this.icr_link;
    }

    public void setIcr_link(String icr_link) {
        this.icr_link = icr_link;
    }
    
}
