package com.camellia.services;

import com.camellia.repositories.QuizParametersRepository;
import com.camellia.models.QuizParameters;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

@Service
public class QuizParametersService {

    private int no_to_identify_specimens = 3;

    private int no_reference_specimens = 6;

    @Autowired
    private QuizParametersRepository repository;

    public Page<QuizParameters> getQuizParameters(Pageable pageable) {
        return repository.findAll(pageable);
    }

    public List<QuizParameters> getQuizParameters() {
        return repository.findAll();
    }

    public QuizParameters getQuizParametersById(long id) {
        return repository.findById((long) id);
    }

    public int getToIdentifyNo(){
        return this.no_to_identify_specimens;
    }

    public int getReferenceNo(){
        return this.no_reference_specimens;
    }
}
