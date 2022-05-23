package com.camellia.models;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.camellia.models.cultivars.Cultivar;
import com.camellia.models.requests.IdentificationRequest;
import com.camellia.models.specimens.Specimen;
import com.camellia.models.users.RegisteredUser;
import com.camellia.models.users.User;
import com.fasterxml.jackson.annotation.JsonIncludeProperties;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Getter
@Setter
@NoArgsConstructor
@Table(name = "quiz")
public class Quiz {
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long quiz_id;    


    @OneToOne(mappedBy = "quiz")
    private IdentificationRequest request;


    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn( referencedColumnName = "userId", name="registered_user", nullable=false)
    @JsonIncludeProperties("registered_user")
    private User registered_user;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn( referencedColumnName = "specimen_id", name="specimen_id", nullable=false)
    @JsonIncludeProperties("specimen_id")
    private Specimen specimen;


    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn( referencedColumnName = "cultivar_id", name="cultivar_id", nullable=false)
    @JsonIncludeProperties("cultivar_id")
    private Cultivar cultivar;
    
}
