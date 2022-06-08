package com.camellia.controllers;

import com.camellia.models.characteristics.UPOVCategoryView;
import com.camellia.services.characteristics.CharacteristicService;
import com.camellia.services.characteristics.UPOVCategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/public/upov")
public class UPOVController {

    @Autowired
    UPOVCategoryService categoryService;
    @Autowired
    CharacteristicService characteristicService;

    @GetMapping("")
    public List<UPOVCategoryView> getCategories() {
        return categoryService.getUPOVCategories();
    }

}
