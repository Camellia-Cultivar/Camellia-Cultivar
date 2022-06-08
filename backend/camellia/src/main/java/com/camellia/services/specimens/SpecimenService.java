package com.camellia.services.specimens;

import com.camellia.models.characteristics.CharacteristicValue;
import com.camellia.repositories.specimens.SpecimenRepository;
import com.camellia.models.specimens.Specimen;
import com.camellia.models.specimens.SpecimenQuizDTO;

import com.camellia.services.characteristics.CharacteristicValueService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class SpecimenService {
    @Autowired
    private SpecimenRepository specimenRepository;

    @Autowired
    private CharacteristicValueService characteristicValueService;


    Logger logger = LogManager.getLogger(SpecimenService.class);

    private Random r = new Random();

    public Page<Specimen> getSpecimens(Pageable pageable) {
        return specimenRepository.findAll(pageable);
    }

    public List<Specimen> getSpecimens() {
        return specimenRepository.findAll();
    }

    public Specimen getSpecimenById(long id) {
        return specimenRepository.findById(id);
    }

    public Specimen saveSpecimen(Specimen specimen){
        try {
            Set<CharacteristicValue> values = specimen.getCharacteristicValues().stream()
                    .map(characteristicValueService::getOrSaveCharacteristicValue)
                    .filter(Objects::nonNull)
                    .collect(Collectors.toSet());

            specimen.setCharacteristicValues(values);
        } catch (NullPointerException e) {
            specimen.setCharacteristicValues(new HashSet<>());
            logger.warn("Found no characteristics in passed specimen");
        }
        return specimenRepository.save(specimen);
    }

    public String deleteSpecimen(long id) {
        specimenRepository.deleteById(id);
        return "Specimen with id="+ id +" removed!";
    }

    public Long getSpecimenCount() {
        return specimenRepository.count();
    }


    public List<SpecimenQuizDTO> getQuizSpecimens( Set<Long> answeredQuizzesIds, int noReferenceSpecimens, int noToIdentifySpecimens ){
        List<SpecimenQuizDTO> specimens = new ArrayList<>();

        List<Long> idsReference = specimenRepository.findAllReferenceIds();
        List<Long> idsToIdentify = specimenRepository.findAllToIdentifyIds();

        List<Long> tempList = new ArrayList<>();
        tempList.addAll(answeredQuizzesIds);

        idsReference.removeAll(tempList);
        idsToIdentify.removeAll(tempList);


        if( idsReference.size() < noReferenceSpecimens ||  idsToIdentify.size() < noToIdentifySpecimens)
            return specimens;

        int refCounter = 0;
        int toIdenCounter = 0;
        int entryId;
        Optional<Specimen> entry;


        
        while(refCounter < noReferenceSpecimens ){
            entryId =  this.r.nextInt(idsReference.size());


            entry = specimenRepository.findById(idsReference.get(entryId));

            if(entry.isPresent()){

                refCounter++;

                idsReference.remove(entryId);
                specimens.add( new SpecimenQuizDTO(entry.get() ) );
            }
        }

        while(toIdenCounter < noToIdentifySpecimens ){

            entryId =  this.r.nextInt(idsToIdentify.size());

            entry = specimenRepository.findById(idsToIdentify.get( entryId) );

            if(entry.isPresent()){
                toIdenCounter++;

                idsToIdentify.remove(entryId);
                specimens.add( new SpecimenQuizDTO(entry.get() ) );
            }
        }

        return specimens;
    }
    public Long getSpecimenPhotosCount() {return specimenRepository.countAllPhotos();}
}
