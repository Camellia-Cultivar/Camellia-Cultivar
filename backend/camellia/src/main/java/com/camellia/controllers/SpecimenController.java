package com.camellia.controllers;

import com.camellia.mappers.SpecimenMapper;
import com.camellia.models.specimens.*;
import com.camellia.services.specimens.*;

import org.springframework.beans.factory.annotation.Autowired;
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
    private ReferenceSpecimenService referenceSpecimenService;

    @GetMapping
    public List<SpecimenDto> getAllSpecimens() {
        return specimenService.getSpecimens()
                .stream()
                .map(SpecimenMapper.MAPPER::specimenToSpecimenDTO)
                .collect(Collectors.toList());
    }

    @GetMapping("/reference")
    public List<ReferenceSpecimenView> getAllReferenceSpecimens(){
        return referenceSpecimenService.getReferenceSpecimensView();
    }

    @GetMapping("/{id}")
    public SpecimenDto getSpecimenById(@PathVariable Long id) {
        return SpecimenMapper.MAPPER.specimenToSpecimenDTO(specimenService.getSpecimenById(id));
    }

    @GetMapping("/recent")
    public List<SpecimenDto> getRecentlyUploaded() {
        return toIdentifySpecimenService.getRecentlyUploaded()
                .stream()
                .map(SpecimenMapper.MAPPER::specimenToSpecimenDTO)
                .collect(Collectors.toList());
    }

    @PostMapping
    public SpecimenDto createSpecimen(@RequestBody SpecimenDto specimenDto) {

        Specimen newSpecimen = specimenService.saveSpecimen(SpecimenMapper.MAPPER.specimenDTOtoToIdentifySpecimen(specimenDto));

        return SpecimenMapper.MAPPER.specimenToSpecimenDTO(newSpecimen);
    }
}
