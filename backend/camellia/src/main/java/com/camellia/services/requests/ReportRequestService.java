package com.camellia.services.requests;

import com.camellia.repositories.requests.ReportRequestRepository;
import com.camellia.repositories.specimens.SpecimenRepository;
import com.camellia.repositories.specimens.ToIdentifySpecimenRepository;
import com.camellia.repositories.users.UserRepository;
import com.camellia.services.users.UserService;
import com.camellia.models.requests.ReportRequest;
import com.camellia.models.requests.ReportRequestDTO;
import com.camellia.models.users.User;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class ReportRequestService {
    @Autowired
    private ReportRequestRepository repository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ToIdentifySpecimenRepository specimenRepository;

    public Page<ReportRequest> getReportRequests(Pageable pageable) {
        return repository.findAll(pageable);
    }

    public List<ReportRequest> getReportRequests() {
        return repository.findAll();
    }

    public ReportRequest getReportRequestById(long id) {
        return repository.findById((long) id);
    }

    public ReportRequest createReportRequest(long specimenId ){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User submittedBy = userRepository.findByEmail( auth.getName() );

        ReportRequest rq = new ReportRequest();
        rq.setSubmissionDate(LocalDateTime.now());
        rq.setReg_user(submittedBy);
        rq.setTo_identify_specimen(specimenRepository.findById(specimenId));

        return repository.save(rq);
    }

    public String deleteReportRequest(long requestId){
        repository.delete(repository.findById(requestId));

        return "Specimen Deleted";
    }

    public ReportRequestDTO getOneRequest(){
        return new ReportRequestDTO(repository.findTopByOrderBySubmissionDate());
    }
}
