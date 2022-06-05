package com.camellia.services;

import com.camellia.repositories.QuizRepository;
import com.camellia.services.cultivars.CultivarService;
import com.camellia.services.specimens.ReferenceSpecimenService;
import com.camellia.services.specimens.SpecimenService;
import com.camellia.services.users.UserService;
import com.camellia.models.QuizAnswer;
import com.camellia.models.QuizAnswerDTO;
import com.camellia.models.specimens.ReferenceSpecimen;
import com.camellia.models.specimens.Specimen;
import com.camellia.models.specimens.SpecimenQuizDTO;
import com.camellia.models.users.User;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

@Service
public class QuizService {
    @Autowired
    private QuizRepository repository;

    @Autowired
    private QuizParametersService quizParametersService;

    @Autowired
    private SpecimenService specimenService;

    @Autowired
    private CultivarService cultivarService;

    @Autowired
    private ReferenceSpecimenService referenceSpecimenService;

    @Autowired
    private UserService userService;

    public Page<QuizAnswer> getQuizzes(Pageable pageable) {
        return repository.findAll(pageable);
    }

    public List<QuizAnswer> getQuizzes() {
        return repository.findAll();
    }

    public QuizAnswer getQuizById(long id) {
        return repository.findById((long) id);
    }

    public List<SpecimenQuizDTO> generateQuiz(long userId){
        int noToIdentifySpecimens = quizParametersService.getToIdentifyNo();
        int noReferenceSpecimens = quizParametersService.getReferenceNo();

        List<SpecimenQuizDTO> quiz = new ArrayList<>();

        User user = userService.getUserById(userId);
        Set<QuizAnswer> answers = repository.findByUser(user);
        Iterator<QuizAnswer> iterator = answers.iterator();

        Set<Long> answeredQuizzesIds = new HashSet<>();

        while(iterator.hasNext()) {
            QuizAnswer f = iterator.next();
            answeredQuizzesIds.add(f.getSpecimen().getSpecimenId());
        }

        quiz = specimenService.getQuizSpecimens(answeredQuizzesIds, noReferenceSpecimens, noToIdentifySpecimens);

        return quiz;
    }


    public double saveQuizAnswers(long userId, List<QuizAnswerDTO> quizAnswers){
        Specimen s;
        User user = userService.getUserById(userId);

        QuizAnswer qaSaved;
        
        System.out.println(quizAnswers);

        for(QuizAnswerDTO qa: quizAnswers){
            s = specimenService.getSpecimenById(qa.getSpecimen_id());

            System.out.println((qa.getSpecimen_id()));
            System.out.println(qa.getAnswer());

            System.out.println(referenceSpecimenService.getReferenceSpecimenById(s.getSpecimenId()).getCultivar().getEpithet());
            
            if( s instanceof ReferenceSpecimen 
                    && referenceSpecimenService.getReferenceSpecimenById(qa.getSpecimen_id()).getCultivar().getEpithet().equals(qa.getAnswer())){
                
                System.out.println("specimen identified");

                user.setReputation(user.getReputation() + 100);
                
                qaSaved = new QuizAnswer();
                qaSaved.setCultivar(cultivarService.getCultivarByEpithet(qa.getAnswer()));
                qaSaved.setSpecimen(specimenService.getSpecimenById(qa.getSpecimen_id()));
                qaSaved.setUser(user);

                repository.save(qaSaved);
                //user.addQuizAnswers(qaSaved);
            }
        }
        return user.getReputation();
    }
}
