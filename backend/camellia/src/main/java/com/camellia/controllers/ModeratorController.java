package com.camellia.controllers;


import com.camellia.models.requests.CultivarRequestDTO;
import com.camellia.models.requests.ReportRequestDTO;
import com.camellia.models.specimens.SpecimenDto;
import com.camellia.models.users.User;
import com.camellia.services.requests.CultivarRequestService;
import com.camellia.services.requests.ReportRequestService;
import com.camellia.services.specimens.ReferenceSpecimenService;
import com.camellia.services.specimens.SpecimenService;
import com.camellia.services.specimens.ToIdentifySpecimenService;
import com.camellia.services.users.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/moderator")
public class ModeratorController {

    @Autowired
    ReportRequestService reportRequestService;

    @Autowired
    SpecimenService specimenService;

    @Autowired
    ToIdentifySpecimenService toIdentifySpecimenService;

    @Autowired
    ReferenceSpecimenService referenceSpecimenService;

    @Autowired
    CultivarRequestService cultivarRequestService;

    @Autowired
    UserService userService;

    @DeleteMapping("/report/{id}")
    public ResponseEntity<String> deleteReportRequest(@PathVariable(value="id") long requestId){
        if(checkRole())
            return ResponseEntity.status(HttpStatus.ACCEPTED).body( reportRequestService.deleteReportRequest(requestId) );
        return ResponseEntity.status(HttpStatus.FORBIDDEN).body(null);
    }

    @GetMapping("/report")
    public ResponseEntity<ReportRequestDTO> getReportRequest(){
        if(checkRole())
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body(reportRequestService.getOneRequest());
        return ResponseEntity.status(HttpStatus.FORBIDDEN).body(null);
    }

    @GetMapping("/cultivar")
    public ResponseEntity<CultivarRequestDTO> getCultivarRequest(){
        if(checkRole())
            return ResponseEntity.status(HttpStatus.ACCEPTED).body( cultivarRequestService.getOneRequest() );
        return ResponseEntity.status(HttpStatus.FORBIDDEN).body(null);

    }

    @DeleteMapping("/cultivar/{id}")
    public ResponseEntity<String> deleteCultivarRequest(@PathVariable(value="id") long requestId){
        if(checkRole())
            return cultivarRequestService.deleteCultivarRequest(requestId);
        return ResponseEntity.status(HttpStatus.FORBIDDEN).body(null);
    }

    @PutMapping("/specimen/promote/{id}")
    public ResponseEntity<SpecimenDto> promoteToReferenceSpecimen(@PathVariable Long id) {
        if(checkRole())
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body(toIdentifySpecimenService.promoteToReferenceFromId(id));
        return ResponseEntity.status(HttpStatus.FORBIDDEN).body(null);

    }

    @PutMapping("/specimen/demote/{id}")
    public ResponseEntity<SpecimenDto> demoteToToIdentifySpecimen(@PathVariable Long id) {
        if(checkRole())
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body(referenceSpecimenService.demoteToToIdentify(id));
        return ResponseEntity.status(HttpStatus.FORBIDDEN).body(null);

    }

    @DeleteMapping("/specimen/{id}")
    public ResponseEntity<String> deleteSpecimen(@PathVariable(value="id") long requestId, @RequestParam(value="specimen") long specimenId){
        if(checkRole()){
            reportRequestService.deleteReportRequest(requestId);
            return ResponseEntity.status(HttpStatus.ACCEPTED).body( specimenService.deleteSpecimen(specimenId) );
        }
        return ResponseEntity.status(HttpStatus.FORBIDDEN).body(null);
    }

    public boolean checkRole(){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User u = userService.getUserByEmail(auth.getName());

        if(u != null && ( u.getRolesList().contains("MOD") || u.getRolesList().contains("ADMIN") ))
            return true;
        
        return false;

    }
}
