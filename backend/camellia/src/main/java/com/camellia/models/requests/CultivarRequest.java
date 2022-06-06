package com.camellia.models.requests;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

// Cultivar Suggestions submited by the users

@Entity
@Getter
@Setter
@NoArgsConstructor
@Table(name = "cultivar_request")
public class CultivarRequest extends Request{
    



    // Name of the cultivar suggested
    @Column( name = "suggestion", nullable = false)
    private String suggestion;

    @Column( name = "icr_link")
    private String icr_link;


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
