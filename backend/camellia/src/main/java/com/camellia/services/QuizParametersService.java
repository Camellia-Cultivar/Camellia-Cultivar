package com.camellia.services;

import com.camellia.repositories.QuizParametersRepository;
import com.camellia.services.users.UserService;
import com.camellia.models.QuizParameters;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class QuizParametersService {

    private int noToIdentifySpecimens = 3;

    private int noReferenceSpecimens = 6;

    @Autowired
    private QuizParametersRepository repository;

    @Autowired
    private UserService userService;

    public Page<QuizParameters> getQuizParameters(Pageable pageable) {
        return repository.findAll(pageable);
    }

    public List<QuizParameters> getQuizParameters() {
        return repository.findAll();
    }

    public QuizParameters getQuizParametersById(long id) {
        return repository.findById(id);
    }

    public int getToIdentifyNo(){
        return this.noToIdentifySpecimens;
    }

    public int getReferenceNo(){
        return this.noReferenceSpecimens;
    }

    public void changeParameters(int noReferenceSpecimens, int noToIdentifySpecimens) {
        QuizParameters qp = new QuizParameters();
        qp.setChangeDate(LocalDateTime.now());
        qp.setNoReferenceSpecimens(noReferenceSpecimens);
        qp.setNoToIdentifySpecimens(noToIdentifySpecimens);

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        qp.setAdminUser(userService.getUserByEmail( auth.getName()) );

        this.noReferenceSpecimens = noReferenceSpecimens;
        this.noToIdentifySpecimens = noToIdentifySpecimens;

        repository.save(qp);
    }
}
