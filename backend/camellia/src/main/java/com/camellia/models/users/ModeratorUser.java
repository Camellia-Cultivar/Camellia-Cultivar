package com.camellia.models.users;

import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.camellia.models.requests.CultivarRequest;
import com.camellia.models.requests.IdentificationRequest;
import com.camellia.models.requests.ReportRequest;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Entity
@Getter
@Setter
@NoArgsConstructor
@Table(name = "moderator_user")
public class ModeratorUser extends User{
    


    @OneToMany(
        fetch = FetchType.EAGER,
        mappedBy = "mod_user",
        cascade = CascadeType.ALL,
        orphanRemoval = true
    )
    @JsonIgnoreProperties("mod_user")
    private Set<IdentificationRequest> identification_requests;

    @OneToMany(
        fetch = FetchType.EAGER,
        mappedBy = "mod_user",
        cascade = CascadeType.ALL,
        orphanRemoval = true
    )
    @JsonIgnoreProperties("mod_user")
    private Set<ReportRequest> report_requests;

    @OneToMany(
        fetch = FetchType.EAGER,
        mappedBy = "mod_user",
        cascade = CascadeType.ALL,
        orphanRemoval = true
    )
    @JsonIgnoreProperties("mod_user")
    private Set<CultivarRequest> cultivar_request;
}
