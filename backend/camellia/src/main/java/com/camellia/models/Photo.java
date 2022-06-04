package com.camellia.models;

import com.camellia.models.specimens.Specimen;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Getter
@Setter
@NoArgsConstructor
@Table(name = "photo")
public class Photo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long photoId;

    @Column(name="url")
    private String url;

    @ManyToOne
    @JoinColumn(name = "specimen_id", nullable = false)
    @JsonIgnoreProperties("specimen_id")
    private Specimen specimen;
}
