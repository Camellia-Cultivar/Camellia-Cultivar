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
    private long parameters_id;

    @Column(name = "change_date", nullable = false)
    private LocalDateTime change_date;

    @Column(name = "weight_standard_specimen_answers")
    private double weight_standard_specimen_answers;

    @Column(name = "weight_user_total_values")
    private double weight_user_total_values;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn( referencedColumnName = "userId", name="user_id", nullable=false)
    @JsonIncludeProperties("user_id")
    private User admin_user;
    

    public long getParameters_id() {
        return this.parameters_id;
    }

    public void setParameters_id(long parameters_id) {
        this.parameters_id = parameters_id;
    }

    public LocalDateTime getChange_date() {
        return this.change_date;
    }

    public void setChange_date(LocalDateTime change_date) {
        this.change_date = change_date;
    }

    public double getWeight_standard_specimen_answers() {
        return this.weight_standard_specimen_answers;
    }

    public void setWeight_standard_specimen_answers(double weight_standard_specimen_answers) {
        this.weight_standard_specimen_answers = weight_standard_specimen_answers;
    }

    public double getWeight_user_total_values() {
        return this.weight_user_total_values;
    }

    public void setWeight_user_total_values(double weight_user_total_values) {
        this.weight_user_total_values = weight_user_total_values;
    }


    public User getAdmin_user() {
        return this.admin_user;
    }

    public void setAdmin_user(User admin_user) {
        this.admin_user = admin_user;
    }

}
