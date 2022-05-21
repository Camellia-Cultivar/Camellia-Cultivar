package com.camellia.models.specimens;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.CollectionTable;
import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.MapKeyJoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.JoinColumn;

import com.camellia.models.cultivars.Cultivar;
import com.camellia.models.requests.IdentificationRequest;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Getter
@Setter
@NoArgsConstructor
@Table( name = "to_identify_specimen")
public class ToIdentifySpecimen extends Specimen{
    

    @OneToMany(
        fetch = FetchType.EAGER,
        mappedBy = "to_identify_specimen",
        cascade = CascadeType.ALL,
        orphanRemoval = true
    )
    @JsonIgnoreProperties("to_identify_specimen")
    private Set<IdentificationRequest> identification_requests;

    @ElementCollection
    @CollectionTable(name = "specimen_might_be",
            joinColumns = @JoinColumn(name = "specimen_id")
    )
    @MapKeyJoinColumn(name = "cultivar_id")
    private Map<Cultivar, Integer> cultivar_votes = new HashMap<>();
}
