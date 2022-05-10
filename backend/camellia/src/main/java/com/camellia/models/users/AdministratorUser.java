package com.camellia.models.users;

import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.camellia.models.QuizParameters;
import com.camellia.models.ReputationParameters;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Getter
@Setter
@NoArgsConstructor
@Table(name = "administrator_user")
public class AdministratorUser extends User{
    
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
