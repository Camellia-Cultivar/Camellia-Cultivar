package com.camellia.models.characteristics;

import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.camellia.models.specimens.Specimen;
import com.fasterxml.jackson.annotation.JsonIncludeProperties;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Getter
@Setter
@NoArgsConstructor
@Table(name = "characteristic_option")
public class CharacteristicOption {
 
    @Id
    @GeneratedValue( strategy =  GenerationType.AUTO)
    private long characteristic_option_id;
    
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn( referencedColumnName = "characteristic_id", name="characteristic_id", nullable=false)
    @JsonIncludeProperties("characteristic_id")
    private Characteristic characteristic;

    @ManyToMany(mappedBy = "characteristic_options")
    Set<Specimen> specimens;
    
    
}
