package com.camellia.models.specimens;

import java.util.Set;


public class SpecimenQuizDTO {
    
    private long specimenId;

    private Set<String> photographs;

    public SpecimenQuizDTO(){}

    public SpecimenQuizDTO(Specimen s){
        this.specimenId = s.getSpecimenId();
        this.photographs = s.getPhotos();
    }


    public long getSpecimenId() {
        return this.specimenId;
    }

    public void setSpecimenId(long specimenId) {
        this.specimenId = specimenId;
    }

    public Set<String> getPhotographs() {
        return this.photographs;
    }

    public void setPhotographs(Set<String> photographs) {
        this.photographs = photographs;
    }

}
