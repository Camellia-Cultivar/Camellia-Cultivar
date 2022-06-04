package com.camellia.models.specimens;

import java.util.Set;

import com.camellia.models.Photo;

public class SpecimenQuizDTO {
    
    private long specimen_id;

    private Set<Photo> photographs;

    public SpecimenQuizDTO(){}

    public SpecimenQuizDTO(Specimen s){
        this.specimen_id = s.getSpecimen_id();
        this.photographs = s.getPhotographs();
    }


    public long getSpecimen_id() {
        return this.specimen_id;
    }

    public void setSpecimen_id(long specimen_id) {
        this.specimen_id = specimen_id;
    }

    public Set<Photo> getPhotographs() {
        return this.photographs;
    }

    public void setPhotographs(Set<Photo> photographs) {
        this.photographs = photographs;
    }

}
