package com.camellia.controllers;

import com.camellia.mappers.IdentificationRequestMapper;
import com.camellia.mappers.SpecimenMapper;
import com.camellia.models.requests.IdentificationRequest;
import com.camellia.models.requests.IdentificationRequestDTO;
import com.camellia.models.requests.IdentificationRequestView;
import com.camellia.models.specimens.Specimen;
import com.camellia.models.specimens.SpecimenDto;
import com.camellia.models.users.User;
import com.camellia.services.requests.IdentificationRequestService;
import com.camellia.services.specimens.SpecimenService;
import com.camellia.services.users.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import com.camellia.models.requests.CultivarRequestDTO;
import com.camellia.services.requests.CultivarRequestService;
import com.camellia.services.requests.ReportRequestService;

import java.util.List;

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

    @PostMapping("/identification")
    public IdentificationRequestDTO createSpecimen(@RequestBody SpecimenDto specimenDto, Authentication authentication) {
        User user = userService.getUserByEmail(authentication.getName());
        if (user == null)
            return null;


        if(user.getAutoApproval() || user.getRolesList().contains("MOD") || user.getRolesList().contains("ADMIN")){
            specimenService.saveSpecimen(
                SpecimenMapper.MAPPER.specimenDTOtoToIdentifySpecimen(specimenDto)
            );
            return null;

        }
        else{
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

    @GetMapping("/identification")
    public ResponseEntity<List<IdentificationRequestView>> getIdentificationRequestsOfUser(Authentication authentication){
        User user = userService.getUserByEmail(authentication.getName());
        if (user == null) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
        }
        return ResponseEntity.ok(identificationRequestService.getAllIdentificationRequestsForUser(user));
    }

    public boolean checkRoleRegistered(){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User u = userService.getUserByEmail(auth.getName());

        return u != null && (u.getRolesList().contains("REGISTERED") || u.getRolesList().contains("MOD") || u.getRolesList().contains("ADMIN"));

    }
}
