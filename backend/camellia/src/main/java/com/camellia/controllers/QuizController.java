package com.camellia.controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.camellia.models.QuizAnswerDTO;
import com.camellia.models.specimens.SpecimenQuizDTO;
import com.camellia.services.QuizService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
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

    @GetMapping(value="/{id}", consumes = {MediaType.APPLICATION_JSON_VALUE})
    public List<SpecimenQuizDTO> generateQuiz(@PathVariable(value = "id") Long userId, HttpServletRequest request){
        return quizService.generateQuiz(userId);
    }


    @PostMapping(value="/{id}", consumes = {MediaType.APPLICATION_JSON_VALUE})
    public double quizSubmission(@RequestBody List<QuizAnswerDTO> answersList, @PathVariable(value="id") long uId){
        return quizService.saveQuizAnswers(uId, answersList);
    }

}
