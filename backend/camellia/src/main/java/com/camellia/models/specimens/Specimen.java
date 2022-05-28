package com.camellia.models.specimens;

import java.time.LocalDateTime;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.InheritanceType;

import com.camellia.models.Country;
import com.camellia.models.Quiz;
import com.camellia.models.characteristics.CharacteristicOption;
import com.camellia.models.users.User;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonIncludeProperties;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Entity
@Inheritance(strategy = InheritanceType.TABLE_PER_CLASS)
@NoArgsConstructor
public abstract class Specimen {
    
    @Id
    @GeneratedValue(generator = "specimen-sequence-generator")
    @GenericGenerator(
        name = "specimen-sequence-generator",
        strategy = "org.hibernate.id.enhanced.SequenceStyleGenerator",
        parameters = {
                    @Parameter(name = "sequence_name", value = "specimen_sequence"),
                    @Parameter(name = "initial_value", value = "1"),
                    @Parameter(name = "increment_size", value = "1")
        }
    )
    private long specimen_id;

    @Column(name = "submission_date", nullable = false)
    private LocalDateTime submission_date;

    @Column(name = "owner")
    private String owner;

    // File System link
    @Column(name = "photographs_link", nullable = false)
    private String photographs_link;

    @Column(name = "address", nullable = false)
    private String address;

    @Column(name = "latitude", nullable = false)
    private double latitude;

    @Column(name = "longitude", nullable = false)
    private double longitude;

    @Column(name = "garden")
    private double garden;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn( referencedColumnName = "userId", name="user_id", nullable=false)
    @JsonIncludeProperties("user_id")
    private User registered_user;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn( referencedColumnName = "country_id", name="country_id", nullable=false)
    @JsonIncludeProperties("country_id")
    private Country country;

    @OneToMany(
        fetch = FetchType.EAGER,
        mappedBy = "specimen",
        cascade = CascadeType.ALL,
        orphanRemoval = true
    )
    @JsonIgnoreProperties("specimen")
    private Set<Quiz> quizzes;

    @ManyToMany
    @JoinTable(
        name = "specimen_contains_option", 
        joinColumns = @JoinColumn(name = "specimen_id"), 
        inverseJoinColumns = @JoinColumn(name = "characteristic_option_id")
    )
    Set<CharacteristicOption> characteristic_options;
}
