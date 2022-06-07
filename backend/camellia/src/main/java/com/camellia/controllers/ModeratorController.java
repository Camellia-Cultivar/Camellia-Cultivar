package com.camellia.controllers;


import com.camellia.models.requests.CultivarRequestDTO;
import com.camellia.models.requests.ReportRequestDTO;
import com.camellia.models.specimens.SpecimenDto;
import com.camellia.services.requests.CultivarRequestService;
import com.camellia.services.requests.ReportRequestService;
import com.camellia.services.specimens.ReferenceSpecimenService;
import com.camellia.services.specimens.SpecimenService;
import com.camellia.services.specimens.ToIdentifySpecimenService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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

    @DeleteMapping("/report/{id}")
    public ResponseEntity<String> deleteReportRequest(@PathVariable(value="id") long requestId){
        return ResponseEntity.status(HttpStatus.ACCEPTED).body( reportRequestService.deleteReportRequest(requestId) );
    }

    @GetMapping("/report")
    public ReportRequestDTO getReportRequest(){
        return reportRequestService.getOneRequest();
    }

    @GetMapping("/cultivar")
    public CultivarRequestDTO getCultivarRequest(){
        return cultivarRequestService.getOneRequest();
    }

    @DeleteMapping("/cultivar/{id}")
    public ResponseEntity<String> deleteCultivarRequest(@PathVariable(value="id") long requestId){
        return cultivarRequestService.deleteCultivarRequest(requestId);
    }

    @PutMapping("/specimen/promote/{id}")
    public SpecimenDto promoteToReferenceSpecimen(@PathVariable Long id) {
        return toIdentifySpecimenService.promoteToReferenceFromId(id);
    }

    @PutMapping("/specimen/demote/{id}")
    public SpecimenDto demoteToToIdentifySpecimen(@PathVariable Long id) {
        return referenceSpecimenService.demoteToToIdentify(id);
    }

    @DeleteMapping("/specimen/{id}")
    public ResponseEntity<String> deleteSpecimen(@PathVariable(value="id") long requestId, @RequestParam(value="specimen") long specimenId){
        reportRequestService.deleteReportRequest(requestId);
        return ResponseEntity.status(HttpStatus.ACCEPTED).body( specimenService.deleteSpecimen(specimenId) );
    }
}
