package com.camellia.controllers;

import com.camellia.models.cultivars.Cultivar;
import com.camellia.models.cultivars.CultivarDTO;
import com.camellia.models.cultivars.CultivarSynonymDTO;
import com.camellia.models.cultivars.CultivarSynonyms;
import com.camellia.models.users.User;
import com.camellia.services.cultivars.CultivarService;
import com.camellia.services.cultivars.CultivarSynonymsService;
import com.camellia.services.requests.CultivarRequestService;
import com.camellia.services.users.UserService;
import com.camellia.views.CultivarListView;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Optional;

import javax.persistence.EntityNotFoundException;
import javax.validation.Valid;

@RestController
@RequestMapping("/api")
public class CultivarController {
    
    @Autowired
    private CultivarService cultivarService;
    @Autowired
    private CultivarRequestService cultivarRequestService;
    @Autowired
    private CultivarSynonymsService cultivarSynonymsService;
    @Autowired
    private UserService userService;

    @GetMapping("/public/cultivars")
    public List<CultivarListView> getCultivarList(@Valid @RequestParam long page){
        return cultivarService.getCultivars(page);
    }

    @GetMapping("/public/cultivars/{id}")
    public CultivarDTO getCultivarById(@PathVariable Long id) {
        return cultivarService.getCultivarById(id);
    }

    @PostMapping("/cultivars/{id}")
    public ResponseEntity<Cultivar> createCultivar( @RequestBody CultivarDTO cultivar, @PathVariable(value="id") long requestId){
        if(checkRoleMod()){
            cultivarRequestService.deleteCultivarRequest(requestId);
            return ResponseEntity.status(HttpStatus.CREATED).body( cultivarService.createCultivar(cultivar));
        }
        return ResponseEntity.status(HttpStatus.FORBIDDEN).body( null);
    }

    @PostMapping("/cultivars/synonyms/{id}")
    public ResponseEntity<CultivarSynonyms> createCultivarSynonym( @RequestBody CultivarSynonymDTO cultivar,  @PathVariable(value="id") long requestId){
        if(checkRoleMod()){
            cultivarRequestService.deleteCultivarRequest(requestId);
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body(cultivarSynonymsService.createCultivarSynonym(cultivar));
        }
        return ResponseEntity.status(HttpStatus.FORBIDDEN).body( null);

    }

    @GetMapping("/public/cultivars/{id}/photos")
    public Page<String> getReferenceSpecimensPhotosForCultivar(
            @PathVariable(name = "id") Long cultivarId,
            @RequestParam(name = "page") Optional<Integer> page,
            @RequestParam(name = "number") Optional<Integer> quantity
    ) {
        return cultivarService.getPhotosOfReferenceSpecimensByCultivarId(
                cultivarService.getOptionalCultivarById(cultivarId).orElseThrow(EntityNotFoundException::new),
                PageRequest.of(page.orElse(0), quantity.orElse(12))
        );
    }

    public boolean checkRoleRegistered(){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User u = userService.getUserByEmail(auth.getName());

        if(u != null && ( u.getRolesList().contains("REGISTERED") || u.getRolesList().contains("MOD") || u.getRolesList().contains("ADMIN") ))
            return true;
        
        return false;

    }


    public boolean checkRoleMod(){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User u = userService.getUserByEmail(auth.getName());

        if(u != null && ( u.getRolesList().contains("MOD") || u.getRolesList().contains("ADMIN") ))
            return true;
        
        return false;

    }
}
