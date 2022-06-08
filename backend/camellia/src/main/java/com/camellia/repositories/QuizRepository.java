package com.camellia.repositories;

import com.camellia.models.QuizAnswer;
import com.camellia.models.users.User;

import java.util.Set;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface QuizRepository extends JpaRepository<QuizAnswer, Long>{
    QuizAnswer findById(long id);

    Set<QuizAnswer> findByUser(User user);

    @Query(value = "SELECT COUNT(*) FROM quiz_answer WHERE user_id = :user_id", nativeQuery = true )
    Long getUserAnswersCount(@Param("user_id") long userId );

    @Query(value = "SELECT COUNT(*) FROM quiz_answer WHERE user_id = :user_id AND correct = true", nativeQuery = true )
    Long getUserCorrectAnswersCount(@Param("user_id") long userId );
}
