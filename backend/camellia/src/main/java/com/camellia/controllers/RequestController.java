package com.camellia.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.camellia.models.requests.CultivarRequestDTO;
import com.camellia.models.requests.ReportRequest;
import com.camellia.models.users.User;
import com.camellia.services.requests.CultivarRequestService;
import com.camellia.services.requests.ReportRequestService;
import com.camellia.services.users.UserService;

@RestController
@RequestMapping("/api/requests")
public class RequestController {
    
    @Autowired
    ReportRequestService reportRequestService;

    @Autowired
    CultivarRequestService cultivarRequestService;

    @Autowired
    private UserService userService;

    @PostMapping("/report/{id}")
    public ResponseEntity<Object> createReportRequest(@PathVariable(value="id") long specimenId){
        if(checkRoleRegistered()){
            reportRequestService.createReportRequest(specimenId);
            return ResponseEntity.status(HttpStatus.CREATED).body("");
        }
        return ResponseEntity.status(HttpStatus.FORBIDDEN).body(null);
    }

    @PostMapping("/cultivar")
    public ResponseEntity<String> createCultivarRequest(@RequestBody CultivarRequestDTO cultivarSuggestion){
        if(checkRoleRegistered())
            return cultivarRequestService.createCultivarRequest(cultivarSuggestion);
        return ResponseEntity.status(HttpStatus.FORBIDDEN).body(null);
    }


    public boolean checkRoleRegistered(){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User u = userService.getUserByEmail(auth.getName());

        if(u != null && ( u.getRolesList().contains("REGISTERED") || u.getRolesList().contains("MOD") || u.getRolesList().contains("ADMIN") ))
            return true;
        
        return false;

    }
}
