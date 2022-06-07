package com.camellia.services.requests;

import com.camellia.mappers.IdentificationRequestMapper;
import com.camellia.models.requests.IdentificationRequestDTO;
import com.camellia.models.specimens.Specimen;
import com.camellia.models.users.User;
import com.camellia.repositories.requests.IdentificationRequestRepository;
import com.camellia.models.requests.IdentificationRequest;

import com.camellia.services.users.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class IdentificationRequestService {
    @Autowired
    private IdentificationRequestRepository repository;

    @Autowired
    private UserService userService;

    Logger logger = LoggerFactory.getLogger(IdentificationRequestService.class);

    public IdentificationRequest createNewIdentificationRequestFromSpecimen(Specimen specimen) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User submittedBy = userService.getUserByEmail( auth.getName() );

        IdentificationRequest newIdentificationRequest = new IdentificationRequest();
        newIdentificationRequest.setSubmissionDate(LocalDateTime.now());
        newIdentificationRequest.setReg_user(submittedBy);
        newIdentificationRequest.setToIdentifySpecimen(specimen);

        return repository.saveAndFlush(newIdentificationRequest);
    }

    public Page<IdentificationRequest> getIdentificationRequests(Pageable pageable) {
        return repository.findAll(pageable);
    }

    public List<IdentificationRequest> getIdentificationRequests() {
        return repository.findAll();
    }

    public IdentificationRequest getIdentificationRequestById(long id) {
        return repository.findById(id);
    }

    public IdentificationRequestDTO approveIdentificationRequest(long id) {
        IdentificationRequest identificationRequest = getIdentificationRequestById(id);
        try {
            identificationRequest.approveRequest();
        } catch (NullPointerException e) {
            logger.error(String.format("IdentificationRequest[requestId=%d] - NOT FOUND", id));
            return null;
        }

        return IdentificationRequestMapper.MAPPER.identificationRequestToIdentificationRequestDTO(
                repository.saveAndFlush(identificationRequest)
        );
    }
}
