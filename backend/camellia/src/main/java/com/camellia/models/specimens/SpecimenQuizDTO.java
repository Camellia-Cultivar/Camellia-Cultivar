package com.camellia.models.specimens;

import java.util.Set;


public class SpecimenQuizDTO {
    
    private long specimen_id;

    private Set<String> photographs;

    public SpecimenQuizDTO(){}

    public SpecimenQuizDTO(Specimen s){
        this.specimen_id = s.getSpecimen_id();
        this.photographs = s.getPhotos();
    }


    public long getSpecimen_id() {
        return this.specimen_id;
    }

    public void setSpecimen_id(long specimen_id) {
        this.specimen_id = specimen_id;
    }

    public Set<String> getPhotographs() {
        return this.photographs;
    }

    public void setPhotographs(Set<String> photographs) {
        this.photographs = photographs;
    }

}
