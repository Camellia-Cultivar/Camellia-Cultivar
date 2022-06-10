package com.camellia.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.camellia.models.users.User;
import com.camellia.services.QuizParametersService;
import com.camellia.services.ReputationParametersService;
import com.camellia.services.users.UserService;

@RestController
@RequestMapping("/api/admin")
public class AdminController {
    
    @Autowired
    private ReputationParametersService reputationParametersService;

    @Autowired
    private QuizParametersService quizParametersService;

    @Autowired
    private UserService userService;

    @PostMapping("/reputation")
    public void changeReputationParameters(
            @RequestParam(value="quiz") double weightStandardSpecimenAnswers,
            @RequestParam(value="votes") double weightUserTotalValues
    ){
        if(checkAdminRole()){
            reputationParametersService.changeParameters(weightStandardSpecimenAnswers, weightUserTotalValues);
        }
    }

    @PostMapping("/quiz")
    public void changeQuizParameters(@RequestParam(value="reference") int noReferenceSpecimens, @RequestParam(value="identify") int noToIdentifySpecimens){
        if(checkAdminRole()){
            quizParametersService.changeParameters(noReferenceSpecimens, noToIdentifySpecimens);
        }
    }


    public boolean checkAdminRole(){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User u = userService.getUserByEmail(auth.getName());

        return u != null && u.getRolesList().contains("ADMIN");
    }
}
