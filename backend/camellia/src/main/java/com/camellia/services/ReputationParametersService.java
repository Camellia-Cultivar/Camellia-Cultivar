package com.camellia.services;

import com.camellia.repositories.ReputationParametersRepository;
import com.camellia.models.ReputationParameters;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

@Service
public class ReputationParametersService {

    private double quizWeight = 0.8;

    private double votesWeight = 0.2;

    @Autowired
    private ReputationParametersRepository repository;

    public Page<ReputationParameters> getReputationParameters(Pageable pageable) {
        return repository.findAll(pageable);
    }

    public List<ReputationParameters> getReputationParameters() {
        return repository.findAll();
    }

    public ReputationParameters getReputationParametersById(long id) {
        return repository.findById((long) id);
    }

    public double getQuizWeight(){
        return this.quizWeight;
    }

    public void setQuizWeight(double quizWeight){
        this.quizWeight = quizWeight;
    }

    public double getVotesWeight(){
        return this.votesWeight;
    }
    
    public void setVotesWeight(double votesWeight){
        this.votesWeight = votesWeight;
    }
}
