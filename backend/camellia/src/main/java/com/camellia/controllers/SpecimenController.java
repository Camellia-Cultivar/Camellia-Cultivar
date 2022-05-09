package com.camellia.controllers;

import com.camellia.services.specimens.SpecimenService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/specimens")
public class SpecimenController {
    
    @Autowired
    private SpecimenService specimen_service;

    
}
