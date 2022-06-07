package com.camellia.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.camellia.models.requests.CultivarRequestDTO;
import com.camellia.services.requests.CultivarRequestService;
import com.camellia.services.requests.ReportRequestService;

@RestController
@RequestMapping("/api/requests")
public class RequestController {
    
    @Autowired
    ReportRequestService reportRequestService;

    @Autowired
    CultivarRequestService cultivarRequestService;

    @PostMapping("/report/{id}")
    public void createReportRequest(@PathVariable(value="id") long specimenId){
        reportRequestService.createReportRequest(specimenId);
    }

    @PostMapping("/cultivar")
    public ResponseEntity<String> createCultivarRequest(@RequestBody CultivarRequestDTO cultivarSuggestion){
        return cultivarRequestService.createCultivarRequest(cultivarSuggestion);
    }

}
