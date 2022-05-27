package com.camellia.models;

import com.camellia.models.specimens.Specimen;

import javax.persistence.*;

@Entity
@Table(name = "photo")
public class Photo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long photoId;

    @Column
    private String url;

    @ManyToOne
    @JoinColumn(name = "specimen_id", nullable = false)
    private Specimen specimen;

    public Photo() {}

    public Long getPhotoId() {
        return photoId;
    }

    public void setPhotoId(Long photoId) {
        this.photoId = photoId;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Specimen getSpecimen() {
        return specimen;
    }

    public void setSpecimen(Specimen specimen) {
        this.specimen = specimen;
    }
}
