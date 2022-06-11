package com.camellia.services.requests;

import com.camellia.repositories.requests.CultivarRequestRepository;
import com.camellia.repositories.users.UserRepository;
import com.camellia.models.requests.CultivarRequest;
import com.camellia.models.requests.CultivarRequestDTO;
import com.camellia.models.users.User;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class CultivarRequestService {
    @Autowired
    private CultivarRequestRepository repository;

    @Autowired
    private UserRepository userRepository;

    public Page<CultivarRequest> getCultivarRequests(Pageable pageable) {
        return repository.findAll(pageable);
    }

    public List<CultivarRequest> getCultivarRequests() {
        return repository.findAll();
    }

    public CultivarRequest getCultivarRequestById(long id) {
        return repository.findById(id);
    }

    public ResponseEntity<String> createCultivarRequest(CultivarRequestDTO cultivarSuggestion){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User submittedBy = userRepository.findByEmail( auth.getName() );

        CultivarRequest cr = new CultivarRequest();
        cr.setSubmissionDate(LocalDateTime.now());
        cr.setRegUser(submittedBy);
        cr.setSuggestion(cultivarSuggestion.getSuggestion());
        cr.setIcr_link(cultivarSuggestion.getIcr_link());
        repository.save(cr);

        return ResponseEntity.status(HttpStatus.CREATED).body("Cultivar suggestion added");
    }

    public CultivarRequestDTO getOneRequest(){
        CultivarRequest cr = repository.findTopByOrderBySubmissionDate();
        if(cr != null)
            return new CultivarRequestDTO(repository.findTopByOrderBySubmissionDate());
        return new CultivarRequestDTO();
    }

    public ResponseEntity<String> deleteCultivarRequest(long requestId){
        CultivarRequest cr = repository.findById(requestId);

        if(cr != null){
            repository.delete(cr);
            return ResponseEntity.status(HttpStatus.ACCEPTED).body("Request Deleted");
        }
        return ResponseEntity.status(HttpStatus.ACCEPTED).body("Unnable to delete request");

    }
}
