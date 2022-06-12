package com.camellia.controllers;

import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import javax.mail.MessagingException;

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

    @GetMapping
    public ResponseEntity<List<SpecimenQuizDTO>> generateQuiz(){
        Optional<User> optionalRequester = userService.getUserFromRequestIfRegistered();
        if(optionalRequester.isEmpty())
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body(null);

        return ResponseEntity.status(HttpStatus.ACCEPTED).body(quizService.generateQuiz(optionalRequester.get()));

    }


    @PostMapping(consumes = {MediaType.APPLICATION_JSON_VALUE})
    public ResponseEntity<String> quizSubmission(@RequestBody List<QuizAnswerDTO> answersList) throws MailException, UnsupportedEncodingException, MessagingException{
        Optional<User> optionalRequester = userService.getUserFromRequestIfRegistered();
        if(optionalRequester.isEmpty())
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body(null);

        List<QuizAnswerDTO> validAnswers =
                answersList.stream()
                        .filter(QuizAnswerDTO::isValid)
                        .collect(Collectors.toList());

        return validAnswers.isEmpty() ?
                ResponseEntity.ok("No responses given")
                : quizService.saveQuizAnswers(optionalRequester.get(), answersList);
    }
}
