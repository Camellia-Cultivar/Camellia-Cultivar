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

    private int no_to_identify_specimens = 3;

    private int no_reference_specimens = 6;

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
        return repository.findById((long) id);
    }

    public int getToIdentifyNo(){
        return this.no_to_identify_specimens;
    }

    public int getReferenceNo(){
        return this.no_reference_specimens;
    }

    public void changeParameters(int no_reference_specimens2, int no_to_identify_specimens2) {
        QuizParameters qp = new QuizParameters();
        qp.setChange_date(LocalDateTime.now());
        qp.setNo_reference_specimens(no_reference_specimens2);
        qp.setNo_to_identify_specimens(no_to_identify_specimens2);

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        qp.setAdmin_user(userService.getUserByEmail( auth.getName()) );

        this.no_reference_specimens = no_reference_specimens2;
        this.no_to_identify_specimens = no_to_identify_specimens2;

        repository.save(qp);
    }
}
