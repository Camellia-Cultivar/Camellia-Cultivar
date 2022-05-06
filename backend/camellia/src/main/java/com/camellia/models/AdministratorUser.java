package com.camellia.models;

import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.NoArgsConstructor;

@Entity
@Table(name = "administrator_user")
@NoArgsConstructor
public class AdministratorUser {
    
    @OneToMany(
            fetch = FetchType.EAGER,
            mappedBy = "admin_user",
            cascade = CascadeType.ALL,
            orphanRemoval = true
    )
    @JsonIgnoreProperties("admin_user")
    private Set<ReputationParameters> reputationParameters;


    @OneToMany(
        fetch = FetchType.EAGER,
        mappedBy = "admin_user",
        cascade = CascadeType.ALL,
        orphanRemoval = true
    )
    @JsonIgnoreProperties("admin_user")
    private Set<QuizParameters> quizParameters;

}
