package com.camellia.controllers;

import com.camellia.services.CultivarService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/cultivars")
public class CultivarController {
    
    @Autowired
    private CultivarService cultivar_service;

    @GetMapping
    public void getCultivarList(){
        
    }
}
