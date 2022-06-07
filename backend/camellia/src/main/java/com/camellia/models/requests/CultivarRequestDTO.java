package com.camellia.models.requests;

public class CultivarRequestDTO {
    
    private String suggestion;

    private String icr_link;
    
    private long regId;

    public CultivarRequestDTO(){}

    public CultivarRequestDTO(CultivarRequest cr){
        this.suggestion = cr.getSuggestion();
        this.icr_link = cr.getIcr_link();
        this.regId = cr.getRegId();
    }


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

    public long getRegId() {
        return this.regId;
    }

    public void setRegId(long regId) {
        this.regId = regId;
    }

}
