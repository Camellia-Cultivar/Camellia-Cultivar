package com.camellia.services;

import com.camellia.mappers.QuizAnswerMapper;
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
import java.util.*;
import java.util.stream.Collectors;

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

    @Autowired
    private QuizAnswerMapper mapper;

    public Page<QuizAnswer> getQuizzes(Pageable pageable) {
        return repository.findAll(pageable);
    }

    public List<QuizAnswer> getQuizzes() {
        return repository.findAll();
    }

    public QuizAnswer getQuizById(long id) {
        return repository.findById(id);
    }

    public List<SpecimenQuizDTO> generateQuiz(User user){
        int noToIdentifySpecimens = quizParametersService.getToIdentifyNo();
        int noReferenceSpecimens = quizParametersService.getReferenceNo();

        List<SpecimenQuizDTO> quiz;

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


    public ResponseEntity<String> saveQuizAnswers(User user, List<QuizAnswerDTO> quizAnswers) throws MailException {

        if(user == null){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Invalid user");
        }

        mapper.quizAnswerDTOsToQuizAnswers(quizAnswers, user).forEach(quizAnswer -> System.out.print(quizAnswer.getCultivar().getId()));

        List<QuizAnswer> answers = repository.saveAll(mapper.quizAnswerDTOsToQuizAnswers(quizAnswers, user));

        answers.stream().filter(QuizAnswer::isToIdentify).forEach(this::calculateSpecimenProbabilities);

        Long correctAnsweredQuizzes = repository.getUserCorrectAnswersCount(user);
        Long totalAnsweredQuizzes = repository.getUserAnswersCount(user);

        Long userTotalVotes = repository.getUserTotalVotes(user);
        Long totalVotes = repository.getTotalVotes();


        userService.saveReputation(user,
                (reputationParametersService.getQuizWeight() * correctAnsweredQuizzes / totalAnsweredQuizzes)
                        + (reputationParametersService.getVotesWeight() * userTotalVotes / totalVotes  )) ;

        return ResponseEntity.status(HttpStatus.ACCEPTED).body(user.getReputation() + "");
    }

    private void calculateSpecimenProbabilities(QuizAnswer quizAnswer) {
        Specimen specimen = quizAnswer.getSpecimen();
        Cultivar cultivar = quizAnswer.getCultivar();

        specimen.addCultivarProb(cultivar, 0);

        Map<Cultivar, Double> probableCultivars = specimen.getProbableCultivarStream()
                .collect(Collectors.toMap(
                        probableCultivar ->  probableCultivar,
                        probableCultivar ->  calculateProbabilityOfSpecimenBeingCultivar(specimen, probableCultivar)
                ));

        specimen.setCultivarProbabilities(probableCultivars);

        Optional<Cultivar> highProbabilityCultivar = probableCultivars.entrySet().stream()
                .filter(cultivarDoubleEntry -> cultivarDoubleEntry.getValue() > 80.0)
                .map(Map.Entry::getKey)
                .findAny();


        if (highProbabilityCultivar.isPresent()) {
            try {
                toIdentifySpecimenService.promoteToReference(specimen, highProbabilityCultivar.get());
            } catch (UnsupportedEncodingException | MessagingException e) {
                throw new RuntimeException(e);
            }
        }

        specimenService.saveSpecimen(specimen);
    }

    private double calculateProbabilityOfSpecimenBeingCultivar(Specimen specimen, Cultivar cultivar) {
        double reputationSum = sumUserReputationThatAnsweredCultivarForSpecimen(cultivar, specimen);
        int totalVotes = specimen.getTotalVotes();

        double prob = reputationSum / totalVotes * 100.0;
        specimen.addCultivarProb(cultivar, prob);

        return prob;
    }

    private double sumUserReputationThatAnsweredCultivarForSpecimen(Cultivar cultivar, Specimen specimen) {
        return repository.getUsersFromCultivar(specimen, cultivar).stream()
                        .map(User::getReputation)
                        .reduce(Double::sum)
                        .orElse(0.0);
    }
}
