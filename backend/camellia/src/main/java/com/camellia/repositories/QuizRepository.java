package com.camellia.repositories;

import com.camellia.models.Quiz;

import org.springframework.data.jpa.repository.JpaRepository;
//import org.springframework.stereotype.Repository;

//@Repository
public interface QuizRepository extends JpaRepository<Quiz, Long>{
    Quiz findById(long id);
}
