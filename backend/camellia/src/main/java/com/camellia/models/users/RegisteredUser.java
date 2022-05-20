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

import lombok.NoArgsConstructor;


@Entity
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


    public double getReputation() {
        return this.reputation;
    }

    public void setReputation(double reputation) {
        this.reputation = reputation;
    }

    public boolean isVerified() {
        return this.verified;
    }

    public boolean getVerified() {
        return this.verified;
    }

    public void setVerified(boolean verified) {
        this.verified = verified;
    }

    public boolean isAuto_approval() {
        return this.auto_approval;
    }

    public boolean getAuto_approval() {
        return this.auto_approval;
    }

    public void setAuto_approval(boolean auto_approval) {
        this.auto_approval = auto_approval;
    }

    public Set<Specimen> getSpecimens() {
        return this.specimens;
    }

    public void setSpecimens(Set<Specimen> specimens) {
        this.specimens = specimens;
    }

    public Set<Quiz> getQuizzes() {
        return this.quizzes;
    }

    public void setQuizzes(Set<Quiz> quizzes) {
        this.quizzes = quizzes;
    }


    public String profile() {
        return "{" + super.profile() + 
            ", " + "\"reputation\":" + getReputation() +
            ", " + "\"auto_approval\":" + isAuto_approval()  +
            "}";
    }
    
}
