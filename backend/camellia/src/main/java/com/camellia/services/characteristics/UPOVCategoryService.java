package com.camellia.services.characteristics;

import com.camellia.models.characteristics.UPOVCategoryView;
import com.camellia.repositories.characteristics.UPOVCategoryRepository;
import com.camellia.models.characteristics.UPOVCategory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

@Service
public class UPOVCategoryService {
    @Autowired
    private UPOVCategoryRepository categoryRepository;

    public List<UPOVCategoryView> getUPOVCategories() {
        return categoryRepository.findBy();
    }

    public UPOVCategoryView getUPOVCategoryById(long id) {
        return categoryRepository.findById(id);
    }
}
