package com.camellia.controllers;

import com.camellia.models.specimens.*;
import com.camellia.models.Country;
import com.camellia.models.cultivars.Cultivar;
import com.camellia.services.CountryService;
import com.camellia.services.specimens.*;
import com.camellia.services.cultivars.CultivarService;

//import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.*;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.*;

//@RequestMapping("/api/specimens")
//comentei para fazer individualmente o mapping dos endpoints
//adicionar @CrossOrigin se der erro de CORS

@RestController
@CrossOrigin
public class SpecimenController {
    
    @Autowired
    private SpecimenService specimen_service;

    @Autowired
    private ReferenceSpecimenService ref_specimen_service;

    @Autowired
    private ToIdentifySpecimenService toId_specimen_service;

    @Autowired
    private CountryService countryService;

    @Autowired
    private CultivarService cultivarService;
    

    @GetMapping("/api/v1/specimens")
    public Page<Specimen> getAllSpecimens(Pageable pageable) {
        return specimen_service.getSpecimens(pageable);
    }

    @GetMapping("/api/v1/specimens/list")
    public List<Specimen> getAllSpecimensList() {
        return specimen_service.getSpecimens();
    }

    @GetMapping("/api/v1/specimen/{id}")
    public Specimen getSpecimen(@PathVariable long id){
        return specimen_service.getSpecimenById(id);
    }

    @GetMapping("/api/v1/specimen/{country}")
    public List<Specimen> getSpecimenByCountry(@PathVariable long country_id){
        Country country = countryService.getCountryById(country_id);
        return specimen_service.getSpecimenByCountry(country);
    }

    @PostMapping("/api/v1/specimens")
    public Specimen createSpecimen(@RequestBody Specimen specimen) {
        return specimen_service.saveSpecimen(specimen);
    }

    @DeleteMapping("/api/v1/specimens/{id}")
    public String deleteSpecimen(@PathVariable long id) {
        return specimen_service.deleteSpecimen(id);
    }

    @PostMapping("api/v1/specimen/promote/{id}")
    public void promoteSpecimen(@PathVariable long id){
        //verificar se o id esta no to_identify_specimen repository
        //ir buscar a cultivar com mais votos(???)
        //valorizar os utilizadores corretos
        //criar nova cultivar
        //transferir detalhes do to_identify_specimen para reference_specimen
        //apagar specimen do repository de to_identify_specimen
    }

    @PostMapping("api/v1/specimen/{id}/addvote/{c_name}")
    public void addVote(@PathVariable("id") long id, @PathVariable("c_name") String c_name){
        Cultivar cultivar = cultivarService.getCultivarByEpithet(c_name);
        ToIdentifySpecimen specimen = toId_specimen_service.getToIdentifySpecimenById(id);
        Map<Cultivar, Integer> votes = specimen.getCultivar_votes();
        if (votes.containsKey(cultivar)){
            votes.put(cultivar, votes.get(cultivar)+1);
        }else{
            votes.put(cultivar, 1);
        }
        toId_specimen_service.updateVotes(specimen, votes);
    }



    //get all specimens, get specimens by id, by uploader, by country, by other characteristic
    //create and delete specimens
    //promote specimens to fully known
    //edit specimens
    //get specimens in a given range of lat and long
    //add cultivar vote for a to_id_specimen
}
