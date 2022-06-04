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

import com.camellia.models.users.AdministratorUser;
import com.camellia.models.users.User;
import com.fasterxml.jackson.annotation.JsonIncludeProperties;

import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
@Table(name = "quiz_parameters")
public class QuizParameters {
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long parameters_id;

    @Column(name = "change_date", nullable = false)
    private LocalDateTime change_date;

    @Column(name = "no_reference_specimens")
    private int no_reference_specimens;

    @Column(name = "no_to_identify_specimens")
    private int no_to_identify_specimens;


    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn( referencedColumnName = "userId", name="user_id", nullable=false)
    @JsonIncludeProperties("user_id")
    private User admin_user;
}
