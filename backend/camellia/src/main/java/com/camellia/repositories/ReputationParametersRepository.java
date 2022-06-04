package com.camellia.repositories;

import com.camellia.models.ReputationParameters;

import org.springframework.data.jpa.repository.JpaRepository;

//@Repository
public interface ReputationParametersRepository extends JpaRepository<ReputationParameters, Long>{
    ReputationParameters findById(long id);
}
