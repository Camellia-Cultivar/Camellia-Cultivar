package com.camellia.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.camellia.models.cultivars.CultivarDTO;
import com.camellia.models.requests.CultivarRequest;
import com.camellia.models.requests.CultivarRequestDTO;
import com.camellia.models.requests.ReportRequest;
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

    @DeleteMapping("/report/{id}")
    public ResponseEntity<String> deleteReportRequest(@PathVariable(value="id") long requestId){
        return ResponseEntity.status(HttpStatus.ACCEPTED).body( reportRequestService.deleteReportRequest(requestId) );
    }
    
    
    @GetMapping("/report")
    public ReportRequest getReportRequest(){
        return reportRequestService.getOneRequest();
    }



    @GetMapping("/cultivar")
    public CultivarRequest getCultivarRequest(){
        return cultivarRequestService.getOneRequest();
    }


    @PostMapping("/cultivar")
    public ResponseEntity<String> createCultivarRequest(@RequestBody CultivarRequestDTO cultivarSuggestion){
        return cultivarRequestService.createCultivarRequest(cultivarSuggestion);
    }

    @DeleteMapping("/cultivar/{id}")
    public ResponseEntity<String> deleteCultivarRequest(@PathVariable(value="id") long requestId){
        return cultivarRequestService.deleteCultivarRequest(requestId);
    }

}
