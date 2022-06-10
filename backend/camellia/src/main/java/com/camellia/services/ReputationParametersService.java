package com.camellia.services;

import com.camellia.repositories.ReputationParametersRepository;
import com.camellia.services.users.UserService;
import com.camellia.models.ReputationParameters;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class ReputationParametersService {

    private double quizWeight = 0.8;

    private double votesWeight = 0.2;

    @Autowired
    private ReputationParametersRepository repository;

    @Autowired
    private UserService userService;

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

    public void changeParameters(double weight_standard_specimen_answers, double weight_user_total_values) {
        ReputationParameters rp = new ReputationParameters();
        rp.setChange_date(LocalDateTime.now());
        rp.setWeight_standard_specimen_answers(weight_standard_specimen_answers);
        rp.setWeight_user_total_values(weight_user_total_values);

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        rp.setAdmin_user(userService.getUserByEmail( auth.getName()) );

        this.quizWeight = weight_standard_specimen_answers;
        this.votesWeight = weight_user_total_values;

        repository.save(rp);
    }
}
