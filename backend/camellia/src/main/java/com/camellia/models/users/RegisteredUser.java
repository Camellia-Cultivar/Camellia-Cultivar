package com.camellia.models.users;

import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.camellia.models.Quiz;
import com.camellia.models.specimens.Specimen;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;



@Entity
@Getter
@Setter
@NoArgsConstructor
@Table(name = "registered_user")
public class RegisteredUser extends User{

    
    @Column(name = "reputation", nullable = false)
    private double reputation;

    @Column(name = "verified", nullable = false)
    private boolean verified;

    @Column(name = "auto_approval", nullable = false)
    private boolean auto_approval;


    @OneToMany(
        fetch = FetchType.EAGER,
        mappedBy = "registered_user",
        cascade = CascadeType.ALL,
        orphanRemoval = true
    )
    @JsonIgnoreProperties("registered_user")
    private Set<Specimen> specimens;

    @OneToMany(
        fetch = FetchType.EAGER,
        mappedBy = "registered_user",
        cascade = CascadeType.ALL,
        orphanRemoval = true
    )
    @JsonIgnoreProperties("registered_user")
    private Set<Quiz> quizzes;
}
