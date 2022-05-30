package com.camellia.controllers;

import com.camellia.models.cultivars.CultivarDTO;
import com.camellia.services.cultivars.CultivarService;
import com.camellia.views.CultivarListView;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

import javax.validation.Valid;

@RestController
@RequestMapping("/api/cultivars")
public class CultivarController {
    
    @Autowired
    private CultivarService cultivarService;

    @GetMapping
    public List<CultivarListView> getCultivarList(@Valid @RequestParam long page){
        return cultivarService.getCultivars(page);
    }

    @GetMapping("/{id}")
    public CultivarDTO getCultivarById(@PathVariable Long id) {
        return cultivarService.getCultivarById(id);
    }
}
