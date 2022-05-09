package com.camellia.models.characteristics;

import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonIncludeProperties;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Getter
@Setter
@NoArgsConstructor
@Table(name = "characteristic")
public class Characteristic {

    @Id
    @GeneratedValue(strategy =  GenerationType.AUTO)
    private long characteristic_id;

    @Column(name = "name")
    private String name;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn( referencedColumnName = "upov_category_id", name="upov_category_id", nullable=false)
    @JsonIncludeProperties("upov_category_id")
    private UPOVCategory upov_category;
 
    
    @OneToMany(
        fetch = FetchType.EAGER,
        mappedBy = "characteristic",
        cascade = CascadeType.ALL,
        orphanRemoval = true
    )
    @JsonIgnoreProperties("characteristic")
    private Set<CharacteristicOption> characteristic_options;

}
