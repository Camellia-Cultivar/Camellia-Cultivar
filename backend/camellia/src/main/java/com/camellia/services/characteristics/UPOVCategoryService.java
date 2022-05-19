package com.camellia.services.characteristics;

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
    private UPOVCategoryRepository repository;

    public Page<UPOVCategory> getUPOVCategories(Pageable pageable) {
        return repository.findAll(pageable);
    }

    public List<UPOVCategory> getUPOVCategories() {
        return repository.findAll();
    }

    public UPOVCategory getUPOVCategoryById(long id) {
        return repository.findById((long) id);
    }
}
