package com.camellia.models;

import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.camellia.models.specimens.Specimen;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Entity
@NoArgsConstructor
@Table( name = "country")
public class Country {
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long country_id;

    @Column(name = "country_code")
    private String country_code;

    @Column(name = "country_name")
    private String country_name;


    @OneToMany(
        fetch = FetchType.EAGER,
        mappedBy = "country",
        cascade = CascadeType.ALL,
        orphanRemoval = true
    )
    @JsonIgnoreProperties("country")
    private Set<Specimen> specimens;
}
