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
    private long parameters_id;

    @Column(name = "change_date", nullable = false)
    private LocalDateTime change_date;

    @Column(name = "no_reference_specimens")
    private int no_reference_specimens;

    @Column(name = "no_to_identify_specimens")
    private int no_to_identify_specimens;


    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn( referencedColumnName = "userId", name="user_id", nullable=false)
    @JsonIgnoreProperties("userId")
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

    public int getNo_reference_specimens() {
        return this.no_reference_specimens;
    }

    public void setNo_reference_specimens(int no_reference_specimens) {
        this.no_reference_specimens = no_reference_specimens;
    }

    public int getNo_to_identify_specimens() {
        return this.no_to_identify_specimens;
    }

    public void setNo_to_identify_specimens(int no_to_identify_specimens) {
        this.no_to_identify_specimens = no_to_identify_specimens;
    }


    public User getAdmin_user() {
        return this.admin_user;
    }

    public void setAdmin_user(User admin_user) {
        this.admin_user = admin_user;
    }

}
