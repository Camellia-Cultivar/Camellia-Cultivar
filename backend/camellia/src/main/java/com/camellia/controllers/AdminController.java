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
    public void changeReputationParameters(@RequestParam(value="quiz") double weight_standard_specimen_answers, @RequestParam(value="votes") double weight_user_total_values){
        if(checkAdminRole()){
            reputationParametersService.changeParameters(weight_standard_specimen_answers, weight_user_total_values);
        }
    }

    @PostMapping("/quiz")
    public void changeQuizParameters(@RequestParam(value="reference") int no_reference_specimens, @RequestParam(value="identify") int no_to_identify_specimens){
        if(checkAdminRole()){
            quizParametersService.changeParameters(no_reference_specimens, no_to_identify_specimens);
        }
    }


    public boolean checkAdminRole(){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User u = userService.getUserByEmail(auth.getName());

        if(u != null && u.getRolesList().contains("ADMIN") )
            return true;
        
        return false;
    }
}
