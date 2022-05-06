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
    @JoinColumn( referencedColumnName = "user_id", name="user_id", nullable=false)
    @JsonIncludeProperties("user_id")
    private AdministratorUser admin_user;
    
}
