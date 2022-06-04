package com.camellia.controllers;

import com.camellia.mappers.SpecimenMapper;
import com.camellia.models.specimens.*;
import com.camellia.services.specimens.*;

import org.mapstruct.factory.Mappers;
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

    private final SpecimenMapper mapper = Mappers.getMapper(SpecimenMapper.class);

    @GetMapping()
    public List<SpecimenDto> getAllSpecimens() {
        return specimenService.getSpecimens()
                .stream()
                .map(mapper::specimenToSpecimenDTO)
                .collect(Collectors.toList());
    }

    @GetMapping("/{id}")
    public SpecimenDto getSpecimenById(@PathVariable Long id) {
        return mapper.specimenToSpecimenDTO(specimenService.getSpecimenById(id));
    }

    @PostMapping
    public SpecimenDto createSpecimen(@RequestBody SpecimenDto specimenDto) {

        Specimen newSpecimen = specimenService.saveSpecimen(mapper.specimenDTOtoToIdentifySpecimen(specimenDto));

        return mapper.specimenToSpecimenDTO(newSpecimen);
    }
}
