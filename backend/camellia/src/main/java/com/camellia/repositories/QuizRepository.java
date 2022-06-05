package com.camellia.repositories;

import com.camellia.models.QuizAnswer;
import com.camellia.models.users.User;

import java.util.Set;

import org.springframework.data.jpa.repository.JpaRepository;

public interface QuizRepository extends JpaRepository<QuizAnswer, Long>{
    QuizAnswer findById(long id);

    Set<QuizAnswer> findByUser(User user);
}
