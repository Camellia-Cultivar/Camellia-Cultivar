package com.camellia.services;

import com.camellia.repositories.QuizRepository;
import com.camellia.models.Quiz;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

@Service
public class QuizService {
    @Autowired
    private QuizRepository repository;

    public Page<Quiz> getQuizzes(Pageable pageable) {
        return repository.findAll(pageable);
    }

    public List<Quiz> getQuizzes() {
        return repository.findAll();
    }

    public Quiz getQuizById(long id) {
        return repository.findById((long) id);
    }
}
