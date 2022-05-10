package com.camellia.repositories.characteristics;

import com.camellia.models.characteristics.UPOVCategory;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UPOVCategoryRepository extends JpaRepository<UPOVCategory, Long>{
    
}
