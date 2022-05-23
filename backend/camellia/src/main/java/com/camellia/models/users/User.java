package com.camellia.models.users;

import java.beans.Transient;
import java.io.Serializable;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.DiscriminatorColumn;
import javax.persistence.DiscriminatorType;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.MappedSuperclass;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.camellia.models.Quiz;
import com.camellia.models.QuizParameters;
import com.camellia.models.ReputationParameters;
import com.camellia.models.requests.CultivarRequest;
import com.camellia.models.requests.IdentificationRequest;
import com.camellia.models.requests.ReportRequest;
import com.camellia.models.specimens.Specimen;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;

import lombok.NoArgsConstructor;

@Entity
@NoArgsConstructor
@Table(name = "users")
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name="user_type", discriminatorType = DiscriminatorType.STRING)
public class User implements Serializable{
    
    @Id
    @GeneratedValue(generator = "user-sequence-generator")
    @GenericGenerator(
        name = "user-sequence-generator",
        strategy = "org.hibernate.id.enhanced.SequenceStyleGenerator",
        parameters = {
                    @Parameter(name = "sequence_name", value = "user_sequence"),
                    @Parameter(name = "initial_value", value = "1"),
                    @Parameter(name = "increment_size", value = "1")
        }
    )
    private long userId;

    @JsonProperty("first_name")
    @Column(name = "first_name", nullable = false)
    private String firstName;

    @JsonProperty("last_name")
    @Column(name = "last_name", nullable = false)
    private String lastName;
    
    @Column(name = "email", nullable = false, unique = true)
    private String email;

    @Column(name = "password", nullable = false)
    private String password;

    @JsonProperty("profile_photo")
    @Column(name = "profile_photo")
    private String profilePhoto;

    @Column(name = "reputation", nullable = false)
    private double reputation;


    @Column(name = "verified", nullable = false)
    private boolean verified;


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

    @OneToMany(
        fetch = FetchType.EAGER,
        mappedBy = "mod_user",
        cascade = CascadeType.ALL,
        orphanRemoval = true
    )
    @JsonIgnoreProperties("mod_user")
    private Set<IdentificationRequest> identificationRequests;

    @OneToMany(
        fetch = FetchType.EAGER,
        mappedBy = "mod_user",
        cascade = CascadeType.ALL,
        orphanRemoval = true
    )
    @JsonIgnoreProperties("mod_user")
    private Set<ReportRequest> reportRequests;

    @OneToMany(
        fetch = FetchType.EAGER,
        mappedBy = "mod_user",
        cascade = CascadeType.ALL,
        orphanRemoval = true
    )
    @JsonIgnoreProperties("mod_user")
    private Set<CultivarRequest> cultivarRequest;

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

    public long getUserId() {
        return this.userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }


    public String getFirstName() {
        return this.firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return this.lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return this.email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return this.password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getProfilePhoto() {
        return this.profilePhoto;
    }

    public void setProfilePhoto(String profilePhoto) {
        this.profilePhoto = profilePhoto;
    }

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

    public Set<IdentificationRequest> getIdentificationRequests() {
        return this.identificationRequests;
    }

    public void setIdentificationRequests(Set<IdentificationRequest> identificationRequests) {
        this.identificationRequests = identificationRequests;
    }

    public Set<ReportRequest> getReportRequests() {
        return this.reportRequests;
    }

    public void setReportRequests(Set<ReportRequest> reportRequests) {
        this.reportRequests = reportRequests;
    }

    public Set<CultivarRequest> getCultivarRequest() {
        return this.cultivarRequest;
    }

    public void setCultivarRequest(Set<CultivarRequest> cultivarRequest) {
        this.cultivarRequest = cultivarRequest;
    }

    public Set<ReputationParameters> getReputationParameters() {
        return this.reputationParameters;
    }

    public void setReputationParameters(Set<ReputationParameters> reputationParameters) {
        this.reputationParameters = reputationParameters;
    }

    public Set<QuizParameters> getQuizParameters() {
        return this.quizParameters;
    }

    public void setQuizParameters(Set<QuizParameters> quizParameters) {
        this.quizParameters = quizParameters;
    }

    @Transient
    public String getDecriminatorValue() {
        return this.getClass().getAnnotation(DiscriminatorValue.class).value();
    }

    public String profile(){
        return "\"profile_image\":" + getProfilePhoto() +
            ", " + "\"first_name\":"  +  getFirstName() + 
            ", " + "\"last_name\":" + getLastName() + 
            ", " + "\"email\":" + getEmail() + 
            ", " + "\"reputation\":" + getReputation(); 
        }
}
