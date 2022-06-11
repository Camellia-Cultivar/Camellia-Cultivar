package com.camellia.repositories;

import com.camellia.models.QuizAnswer;
import com.camellia.models.specimens.Specimen;
import com.camellia.models.users.User;

import java.util.List;
import java.util.Set;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface QuizRepository extends JpaRepository<QuizAnswer, Long>{
    QuizAnswer findById(long id);

    Set<QuizAnswer> findByUser(User user);

    @Query(value = "SELECT COUNT(*) FROM quiz_answer WHERE user_id = :user_id AND specimen_type = \'REFERENCE\'", nativeQuery = true )
    Long getUserAnswersCount(@Param("user_id") long userId );

    @Query(value = "SELECT COUNT(*) FROM quiz_answer WHERE user_id = :user_id AND correct = true AND specimen_type = \'REFERENCE\'", nativeQuery = true )
    Long getUserCorrectAnswersCount(@Param("user_id") long userId );

    @Query(nativeQuery = true, value = "SELECT user_id FROM quiz_answer WHERE specimen_id = :specimen_id AND cultivar_id = :cultivar_id")
    List<Long> getUsersFromCultivar(@Param("specimen_id") Long specimenId, @Param("cultivar_id") Long cultivarId);

    @Query(value = "SELECT COUNT(*) FROM quiz_answer WHERE user_id = :user_id AND specimen_type = \'TOIDENTIFY\'", nativeQuery = true )
    Long getUserTotalVotes(@Param("user_id") Long userId);

    @Query(value = "SELECT COUNT(*) FROM quiz_answer WHERE specimen_type = \'TOIDENTIFY\'", nativeQuery = true )
    Long getTotalVotes();

    @Query(value = "SELECT COUNT(*) FROM quiz_answer WHERE specimen_id= :specimenId", nativeQuery = true)
    int getTotalVotesForSpecimen(@Param("specimenId") long specimenId);


}
