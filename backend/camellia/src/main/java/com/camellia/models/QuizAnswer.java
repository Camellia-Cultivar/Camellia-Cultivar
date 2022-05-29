package com.camellia.models;

import javax.persistence.*;

import com.camellia.models.cultivars.Cultivar;
import com.camellia.models.specimens.Specimen;
import com.camellia.models.users.User;
import com.fasterxml.jackson.annotation.JsonIncludeProperties;

@Entity
@Table(name = "quiz_answer")
public class QuizAnswer {
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

    @ManyToOne
    @JoinColumn( name="registered_user", nullable=false)
    @JsonIncludeProperties("user_id")
    private User user;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn( referencedColumnName = "specimen_id", name="specimen_id", nullable=false)
    @JsonIncludeProperties("specimen_id")
    private Specimen specimen;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn( referencedColumnName = "cultivar_id", name="cultivar_id", nullable=false)
    @JsonIncludeProperties("cultivar_id")
    private Cultivar cultivar;
    
}
