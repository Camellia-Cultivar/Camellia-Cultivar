package com.camellia.controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.camellia.models.QuizAnswer;
import com.camellia.services.QuizService;

import org.springframework.beans.factory.annotation.Autowired;
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

    @GetMapping(value="/{id}")
    public void generateQuiz(@PathVariable(value = "id") Long user_id, HttpServletRequest request){
        
    }


    @PostMapping
    public void quizSubmission(@RequestBody List<QuizAnswer> answersList){
        System.out.println(answersList);
    }

}
