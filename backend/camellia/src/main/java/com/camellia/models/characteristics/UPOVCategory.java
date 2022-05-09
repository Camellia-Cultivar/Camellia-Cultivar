package com.camellia.models.characteristics;

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

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Getter
@Setter
@NoArgsConstructor
@Table(name = "upov_category")
public class UPOVCategory {
    
    @Id
    @GeneratedValue( strategy = GenerationType.AUTO)
    private long upov_category_id;

    @Column(name = "name")
    private String name;

    @OneToMany(
        fetch = FetchType.EAGER,
        mappedBy = "upov_category",
        cascade = CascadeType.ALL,
        orphanRemoval = true
    )
    @JsonIgnoreProperties("upov_category")
    private Set<Characteristic> characteristics;
}
