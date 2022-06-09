package com.camellia.models;

import javax.persistence.*;

import com.camellia.models.cultivars.Cultivar;
import com.camellia.models.specimens.Specimen;
import com.camellia.models.users.User;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.NoArgsConstructor;

@Entity
@NoArgsConstructor
@Table(name = "quiz_answer", uniqueConstraints={
    @UniqueConstraint(columnNames = {"userId", "specimen_id"})
})
public class QuizAnswer {
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

    @Column(name = "correct")
    private boolean correct;

    @Column(name = "specimen_type")
    private String specimenType;

    @ManyToOne
    @JoinColumn( name="userId", nullable=false)
    @JsonIgnoreProperties("user")
    private User user;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn( referencedColumnName = "specimen_id", name="specimen_id", nullable=false)
    @JsonIgnoreProperties("specimen_id")
    private Specimen specimen;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn( referencedColumnName = "cultivar_id", name="cultivar_id", nullable=false)
    @JsonIgnoreProperties("cultivar_id")
    private Cultivar cultivar;
    

    public long getId() {
        return this.id;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public void setCorrect(boolean isCorrect){
        this.correct = isCorrect;
    }

    public boolean getCorrect(){
        return this.correct;
    }

    public void setSpecimenType(String specimenType){
        this.specimenType = specimenType;
    }

    public String getSpecimenType(){
        return this.specimenType;
    }

    public void setSpecimen(Specimen specimen) {
        this.specimen = specimen;
    }
    
    public Specimen getSpecimen(){
        return this.specimen;
    }

    public void setCultivar(Cultivar cultivar) {
        this.cultivar = cultivar;
    }
}
