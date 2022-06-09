package com.camellia.controllers;

import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;

import com.camellia.models.QuizAnswerDTO;
import com.camellia.models.specimens.SpecimenQuizDTO;
import com.camellia.models.users.User;
import com.camellia.services.QuizService;
import com.camellia.services.users.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.MailException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/quizzes")
public class QuizController {
    
    @Autowired
    private QuizService quizService;

    @Autowired
    private UserService userService;

    @GetMapping(value="/{id}")
    public ResponseEntity<List<SpecimenQuizDTO>> generateQuiz(@PathVariable(value = "id") Long userId, HttpServletRequest request){
        if(checkRoleRegistered())
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body(quizService.generateQuiz(userId));
        return ResponseEntity.status(HttpStatus.FORBIDDEN).body(null);

    }


    @PostMapping(value="/{id}", consumes = {MediaType.APPLICATION_JSON_VALUE})
    public ResponseEntity<String> quizSubmission(@RequestBody List<QuizAnswerDTO> answersList, @PathVariable(value="id") long uId) throws MailException, UnsupportedEncodingException, MessagingException{
        if(checkRoleRegistered())
            return quizService.saveQuizAnswers(uId, answersList);
        return ResponseEntity.status(HttpStatus.FORBIDDEN).body(null);
    }


    public boolean checkRoleRegistered(){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User u = userService.getUserByEmail(auth.getName());

        if(u != null && ( u.getRolesList().contains("REGISTERED") || u.getRolesList().contains("MOD") || u.getRolesList().contains("ADMIN") ))
            return true;
        
        return false;

    }
}
