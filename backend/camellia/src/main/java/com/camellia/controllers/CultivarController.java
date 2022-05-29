package com.camellia.controllers;

import com.camellia.models.cultivars.Cultivar;
import com.camellia.services.cultivars.CultivarService;
import com.camellia.views.CultivarView;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Optional;

import javax.validation.Valid;

@RestController
@RequestMapping("/api/cultivars")
public class CultivarController {
    
    @Autowired
    private CultivarService cultivarService;

    @GetMapping
    public List<CultivarView> getCultivarList(@Valid @RequestParam long page){
        return cultivarService.getCultivars(page);
    }

    @GetMapping("/{id}")
    public Optional<Cultivar> getCultivarById(@PathVariable Long id) {
        return cultivarService.getCultivarById(id);
    }
}
