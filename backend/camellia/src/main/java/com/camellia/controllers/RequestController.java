package com.camellia.controllers;

import com.camellia.mappers.IdentificationRequestMapper;
import com.camellia.mappers.SpecimenMapper;
import com.camellia.models.requests.IdentificationRequest;
import com.camellia.models.requests.IdentificationRequestDTO;
import com.camellia.models.specimens.Specimen;
import com.camellia.models.specimens.SpecimenDto;
import com.camellia.models.users.User;
import com.camellia.services.requests.IdentificationRequestService;
import com.camellia.services.specimens.SpecimenService;
import com.camellia.services.users.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
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

    @Autowired
    IdentificationRequestService identificationRequestService;

    @Autowired
    UserService userService;

    @Autowired
    SpecimenService specimenService;

    @PostMapping("/report/{id}")
    public void createReportRequest(@PathVariable(value="id") long specimenId){
        reportRequestService.createReportRequest(specimenId);
    }

    @PostMapping("/cultivar")
    public ResponseEntity<String> createCultivarRequest(@RequestBody CultivarRequestDTO cultivarSuggestion){
        return cultivarRequestService.createCultivarRequest(cultivarSuggestion);
    }

    @PostMapping("/identification")
    public IdentificationRequestDTO createSpecimen(@RequestBody SpecimenDto specimenDto, Authentication authentication) {
        User user = userService.getUserByEmail(authentication.getName());

        if (user == null)
            return null;

        Specimen newSpecimen = specimenService.saveSpecimen(
                SpecimenMapper.MAPPER.specimenDTOtoToForApprovalSpecimen(specimenDto)
        );

        IdentificationRequest newIdentificationRequest =
                identificationRequestService.createNewIdentificationRequestFromSpecimen(newSpecimen);

        return IdentificationRequestMapper.MAPPER.identificationRequestToIdentificationRequestDTO(
                newIdentificationRequest
        );
    }

}
