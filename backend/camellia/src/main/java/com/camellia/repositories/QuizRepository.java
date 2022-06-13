package com.camellia.repositories;

import com.camellia.models.QuizAnswer;
import com.camellia.models.cultivars.Cultivar;
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

//    @Query(value = "SELECT COUNT(*) FROM quiz_answer WHERE user_id = :user_id AND specimen_type = \'REFERENCE\'", nativeQuery = true )
    @Query(value =
            "SELECT COUNT(a) FROM QuizAnswer a " +
                    "WHERE a.user = :user " +
                    "AND a.specimenType = com.camellia.models.specimens.SpecimenType.REFERENCE")
    Long getUserAnswersCount(@Param("user") User user);

//    @Query(value = "SELECT COUNT(*) FROM quiz_answer WHERE user_id = :user_id AND correct = true AND specimen_type = \'REFERENCE\'", nativeQuery = true )
    @Query(value =
            "SELECT COUNT(a) FROM QuizAnswer a " +
                    "WHERE a.user = :user " +
                    "AND a.correct = true " +
                    "AND a.specimenType = com.camellia.models.specimens.SpecimenType.REFERENCE" )
    Long getUserCorrectAnswersCount(@Param("user") User user);

//    @Query(nativeQuery = true, value = "SELECT user_id FROM quiz_answer WHERE specimen_id = :specimen_id AND cultivar_id = :cultivar_id")
    @Query(value = "SELECT a.user FROM QuizAnswer a WHERE a.specimen = :specimen AND a.cultivar = :cultivar")
    List<User> getUsersFromCultivar(@Param("specimen") Specimen specimen, @Param("cultivar") Cultivar cultivar);

//    @Query(value = "SELECT COUNT(*) FROM quiz_answer WHERE user_id = :user_id AND specimen_type = \'TOIDENTIFY\'", nativeQuery = true )
    @Query(value =
            "SELECT COUNT(a) FROM QuizAnswer a " +
                    "WHERE a.user = :user " +
                    "AND a.specimenType = com.camellia.models.specimens.SpecimenType.TO_IDENTIFY")
    Long getUserTotalVotes(@Param("user") User user);

    @Query(value = "SELECT COUNT(a) FROM QuizAnswer a WHERE a.specimenType = com.camellia.models.specimens.SpecimenType.TO_IDENTIFY")
    Long getTotalVotes();

    @Query(value = "SELECT COUNT(*) FROM quiz_answer WHERE specimen_id= :specimenId", nativeQuery = true)
    int getTotalVotesForSpecimen(@Param("specimenId") long specimenId);


}
