package com.camellia.models;

public class QuizAnswerDTO {
    
    private long specimen_id;

    private String answer;

    public QuizAnswerDTO(){

    }


    public long getSpecimen_id() {
        return this.specimen_id;
    }

    public void setSpecimen_id(long specimenId) {
        this.specimen_id = specimenId;
    }

    public String getAnswer() {
        return this.answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

}
