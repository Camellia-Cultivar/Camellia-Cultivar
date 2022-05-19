package com.camellia.repositories;

import com.camellia.models.QuizParameters;

import org.springframework.data.jpa.repository.JpaRepository;
//import org.springframework.stereotype.Repository;

//@Repository
public interface QuizParametersRepository extends JpaRepository<QuizParameters, Long>{
    QuizParameters findById(long id);
}
