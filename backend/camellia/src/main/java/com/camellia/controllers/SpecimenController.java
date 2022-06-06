package com.camellia.controllers;

import com.camellia.mappers.SpecimenMapper;
import com.camellia.models.specimens.*;
import com.camellia.services.requests.ReportRequestService;
import com.camellia.services.specimens.*;

import org.mapstruct.factory.Mappers;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.*;


import java.util.*;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/public/specimen")
public class SpecimenController {
    
    @Autowired
    private SpecimenService specimenService;

    @Autowired
    private ToIdentifySpecimenService toIdentifySpecimenService;

    @Autowired
    private ReportRequestService reportRequestService;

    @Autowired
    private ReferenceSpecimenService referenceSpecimenService;

    private final SpecimenMapper mapper = Mappers.getMapper(SpecimenMapper.class);

    @GetMapping()
    public List<SpecimenDto> getAllSpecimens() {
        return specimenService.getSpecimens()
                .stream()
                .map(mapper::specimenToSpecimenDTO)
                .collect(Collectors.toList());
    }

    @GetMapping("/reference")
    public List<ReferenceSpecimenView> getAllReferenceSpecimens(){
        return referenceSpecimenService.getReferenceSpecimensView();
    }

    @GetMapping("/{id}")
    public SpecimenDto getSpecimenById(@PathVariable Long id) {
        return mapper.specimenToSpecimenDTO(specimenService.getSpecimenById(id));
    }

    @GetMapping("/recent")
    public List<SpecimenDto> getRecentlyUploaded() {
        return toIdentifySpecimenService.getRecentlyUploaded()
                .stream()
                .map(mapper::specimenToSpecimenDTO)
                .collect(Collectors.toList());
    }

    @PostMapping
    public SpecimenDto createSpecimen(@RequestBody SpecimenDto specimenDto) {

        Specimen newSpecimen = specimenService.saveSpecimen(mapper.specimenDTOtoToIdentifySpecimen(specimenDto));

        return mapper.specimenToSpecimenDTO(newSpecimen);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteSpecimen(@PathVariable(value="id") long requestId, @RequestParam(value="specimen") long specimenId){
        reportRequestService.deleteReportRequest(requestId);
        return ResponseEntity.status(HttpStatus.ACCEPTED).body( specimenService.deleteSpecimen(specimenId) );
    }
}
