package com.camellia.controllers;

import com.camellia.models.cultivars.Cultivar;
import com.camellia.models.cultivars.CultivarDTO;
import com.camellia.models.cultivars.CultivarSynonymDTO;
import com.camellia.models.cultivars.CultivarSynonyms;
import com.camellia.models.requests.CultivarRequestDTO;
import com.camellia.models.users.User;
import com.camellia.services.cultivars.CultivarService;
import com.camellia.services.cultivars.CultivarSynonymsService;
import com.camellia.services.requests.CultivarRequestService;
import com.camellia.services.users.UserService;
import com.camellia.views.CultivarListView;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

import javax.validation.Valid;

@RestController
@RequestMapping("/api/public/cultivars")
public class CultivarController {
    
    @Autowired
    private CultivarService cultivarService;

    @Autowired
    private CultivarRequestService cultivarRequestService;


    @Autowired
    private CultivarSynonymsService cultivarSynonymsService;

    @Autowired
    private UserService userService;

    @GetMapping
    public List<CultivarListView> getCultivarList(@Valid @RequestParam long page){
        return cultivarService.getCultivars(page);
    }

    @GetMapping("/{id}")
    public CultivarDTO getCultivarById(@PathVariable Long id) {
        return cultivarService.getCultivarById(id);
    }

    @PostMapping("/{id}")
    public ResponseEntity<Cultivar> createCultivar( @RequestBody CultivarDTO cultivar, @PathVariable(value="id") long requestId){
        if(checkRoleMod()){
            cultivarRequestService.deleteCultivarRequest(requestId);
            return ResponseEntity.status(HttpStatus.CREATED).body( cultivarService.createCultivar(cultivar));
        }
        return ResponseEntity.status(HttpStatus.FORBIDDEN).body( null);
    }

    @PostMapping("/synonyms/{id}")
    public ResponseEntity<CultivarSynonyms> createCultivarSynonym( @RequestBody CultivarSynonymDTO cultivar,  @PathVariable(value="id") long requestId){
        if(checkRoleMod()){
            cultivarRequestService.deleteCultivarRequest(requestId);
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body(cultivarSynonymsService.createCultivarSynonym(cultivar));
        }
        return ResponseEntity.status(HttpStatus.FORBIDDEN).body( null);

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
