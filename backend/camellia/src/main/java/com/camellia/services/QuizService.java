package com.camellia.services;

import com.camellia.repositories.QuizRepository;
import com.camellia.services.cultivars.CultivarService;
import com.camellia.services.specimens.ReferenceSpecimenService;
import com.camellia.services.specimens.SpecimenService;
import com.camellia.services.specimens.ToIdentifySpecimenService;
import com.camellia.services.users.UserService;
import com.camellia.models.QuizAnswer;
import com.camellia.models.QuizAnswerDTO;
import com.camellia.models.cultivars.Cultivar;
import com.camellia.models.specimens.Specimen;
import com.camellia.models.specimens.SpecimenQuizDTO;
import com.camellia.models.users.User;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.MailException;

import java.io.UnsupportedEncodingException;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.mail.MessagingException;

@Service
public class QuizService {
    @Autowired
    private QuizRepository repository;

    @Autowired
    private QuizParametersService quizParametersService;

    @Autowired
    private ReputationParametersService reputationParametersService;

    @Autowired
    private SpecimenService specimenService;

    @Autowired
    private CultivarService cultivarService;

    @Autowired
    private ReferenceSpecimenService referenceSpecimenService;

    @Autowired
    private ToIdentifySpecimenService toIdentifySpecimenService;

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

        List<SpecimenQuizDTO> quiz;

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


    public ResponseEntity<String> saveQuizAnswers(long userId, List<QuizAnswerDTO> quizAnswers) throws MailException, UnsupportedEncodingException, MessagingException{
        Specimen s;
        User user = userService.getUserById(userId);

        if(user == null){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Invalid user");
        }

        QuizAnswer qaSaved;
        boolean correct;

        for(QuizAnswerDTO qa: quizAnswers){
            s = specimenService.getSpecimenById(qa.getSpecimen_id());


            Cultivar c = cultivarService.getCultivarById(qa.getAnswer());

            if(c == null){
                ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Invalid Cultivar");
            }

            qaSaved = new QuizAnswer();
            qaSaved.setCultivar(c);
            qaSaved.setSpecimen(s);


            qaSaved.setUser(user);



            if( s.isReference()){

                if(c != null && referenceSpecimenService.getReferenceSpecimenById(qa.getSpecimen_id()).getCultivar().getId() == qa.getAnswer() ){
                    correct = true;
                } 
                else {
                    correct = false;
                }

                qaSaved.setCorrect(correct);
                qaSaved.setSpecimenType("REFERENCE");

                repository.save(qaSaved);
            }
            else if( s.isToIdentify()){



                qaSaved.setCorrect(false);
                qaSaved.setSpecimenType("TOIDENTIFY");

                repository.save(qaSaved);


                int totalVotes = repository.getTotalVotesForSpecimen(s.getSpecimenId());


                int reputationSum;

                s.addCultivarProb(c, 0);

                for(Cultivar tempC : s.getCultivarProbabilities().keySet()){
                    reputationSum = 0;
                    for(Long id : repository.getUsersFromCultivar(s.getSpecimenId(), tempC.getId())){
                        reputationSum += userService.getUserById(id).getReputation();
                    }

                    double prob = reputationSum / totalVotes * 100 ;
                    s.addCultivarProb(c, prob);
                    specimenService.saveSpecimen(s);

                    if( prob > 80){
                        toIdentifySpecimenService.promoteToReferenceFromId(s.getSpecimenId(), tempC);
                        break;
                    }
                }

                
            }
        }

        Long correctAnsweredQuizzes = repository.getUserCorrectAnswersCount(userId);
        Long totalAnsweredQuizzes = repository.getUserAnswersCount(userId);

        Long userTotalVotes = repository.getUserTotalVotes(userId);
        Long totalVotes = repository.getTotalVotes();


        user.setReputation( (reputationParametersService.getQuizWeight() * correctAnsweredQuizzes / totalAnsweredQuizzes)  + 
            (reputationParametersService.getVotesWeight() * userTotalVotes / totalVotes  )) ;

        return ResponseEntity.status(HttpStatus.ACCEPTED).body(user.getReputation() + "");
    }
}
