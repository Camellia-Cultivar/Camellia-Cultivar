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
import com.fasterxml.jackson.annotation.JsonIncludeProperties;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Getter
@Setter
@NoArgsConstructor
@Table(name = "reputation_parameters")
public class ReputationParameters {
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "parameters_id")
    private long parametersId;

    @Column(name = "change_date", nullable = false)
    private LocalDateTime changeDate;

    @Column(name = "weight_standard_specimen_answers")
    private double weightStandardSpecimenAnswers;

    @Column(name = "weight_user_total_values")
    private double weightUserTotalValues;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn( referencedColumnName = "userId", name="user_id", nullable=false)
    @JsonIncludeProperties("user_id")
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

    public double getWeightStandardSpecimenAnswers() {
        return this.weightStandardSpecimenAnswers;
    }

    public void setWeightStandardSpecimenAnswers(double weightStandardSpecimenAnswers) {
        this.weightStandardSpecimenAnswers = weightStandardSpecimenAnswers;
    }

    public double getWeightUserTotalValues() {
        return this.weightUserTotalValues;
    }

    public void setWeightUserTotalValues(double weightUserTotalValues) {
        this.weightUserTotalValues = weightUserTotalValues;
    }


    public User getAdminUser() {
        return this.adminUser;
    }

    public void setAdminUser(User adminUser) {
        this.adminUser = adminUser;
    }

}
