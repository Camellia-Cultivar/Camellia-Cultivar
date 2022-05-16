package com.camellia.repositories;

//import org.springframework.stereotype.Repository;

import com.camellia.models.ReputationParameters;

import org.springframework.data.jpa.repository.JpaRepository;

//@Repository
public interface ReputationParametersRepository extends JpaRepository<ReputationParameters, Long>{
    ReputationParameters findById(long id);
}
