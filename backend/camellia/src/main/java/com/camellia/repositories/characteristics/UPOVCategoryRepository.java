package com.camellia.repositories.characteristics;

import com.camellia.models.characteristics.UPOVCategory;

import com.camellia.models.characteristics.UPOVCategoryView;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface UPOVCategoryRepository extends JpaRepository<UPOVCategory, Long>{
    UPOVCategoryView findById(long id);
    List<UPOVCategoryView> findBy();
}
