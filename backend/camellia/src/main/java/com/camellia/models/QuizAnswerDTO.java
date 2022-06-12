package com.camellia.models;

public class QuizAnswerDTO {
    
    private Long specimenId;

    private Long answer;

    public QuizAnswerDTO(){

    }


    public Long getSpecimenId() {
        return this.specimenId;
    }

    public void setSpecimenId(Long specimenId) {
        this.specimenId = specimenId;
    }

    public Long getAnswer() {
        return this.answer;
    }

    public void setAnswer(Long answer) {
        this.answer = answer;
    }

    public boolean isValid() {
        return specimenId != null && answer != null;
    }

}
