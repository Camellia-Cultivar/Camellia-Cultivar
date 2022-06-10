package com.camellia.models;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.camellia.models.users.User;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Getter
@Setter
@NoArgsConstructor
@Table(name = "quiz_parameters")
public class QuizParameters {
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "parameters_id")
    private long parametersId;

    @Column(name = "change_date", nullable = false)
    private LocalDateTime changeDate;

    @Column(name = "no_reference_specimens")
    private int noReferenceSpecimens;

    @Column(name = "no_to_identify_specimens")
    private int noToIdentifySpecimens;


    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn( referencedColumnName = "userId", name="user_id", nullable=false)
    @JsonIgnoreProperties("userId")
    private User adminUser;


    public long getParametersId() {
        return this.parametersId;
    }

    public void setParametersId(long parametersId) {
        this.parametersId = parametersId;
    }

    public LocalDateTime getChangeDate() {
        return this.changeDate;
    }

    public void setChangeDate(LocalDateTime changeDate) {
        this.changeDate = changeDate;
    }

    public int getNoReferenceSpecimens() {
        return this.noReferenceSpecimens;
    }

    public void setNoReferenceSpecimens(int noReferenceSpecimens) {
        this.noReferenceSpecimens = noReferenceSpecimens;
    }

    public int getNoToIdentifySpecimens() {
        return this.noToIdentifySpecimens;
    }

    public void setNoToIdentifySpecimens(int noToIdentifySpecimens) {
        this.noToIdentifySpecimens = noToIdentifySpecimens;
    }


    public User getAdminUser() {
        return this.adminUser;
    }

    public void setAdminUser(User adminUser) {
        this.adminUser = adminUser;
    }

}
