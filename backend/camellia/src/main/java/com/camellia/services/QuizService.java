package com.camellia.services;

import com.camellia.repositories.QuizRepository;
import com.camellia.models.QuizAnswer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

@Service
public class QuizService {
    @Autowired
    private QuizRepository repository;

    public Page<QuizAnswer> getQuizzes(Pageable pageable) {
        return repository.findAll(pageable);
    }

    public List<QuizAnswer> getQuizzes() {
        return repository.findAll();
    }

    public QuizAnswer getQuizById(long id) {
        return repository.findById((long) id);
    }
}
