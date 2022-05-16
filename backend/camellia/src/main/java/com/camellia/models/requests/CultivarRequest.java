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

    
}
