package com.camellia.services.specimens;

import com.camellia.repositories.specimens.ReferenceSpecimenRepository;
import com.camellia.repositories.specimens.SpecimenRepository;
import com.camellia.repositories.specimens.ToIdentifySpecimenRepository;
import com.camellia.models.specimens.ReferenceSpecimen;
import com.camellia.models.specimens.Specimen;
import com.camellia.models.specimens.SpecimenQuizDTO;
import com.camellia.models.specimens.ToIdentifySpecimen;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.Random;
import java.util.Set;

@Service
public class SpecimenService {
    @Autowired
    private SpecimenRepository repository;

    @Autowired
    private ReferenceSpecimenRepository referenceSpecimenRepository;

    @Autowired 
    private ToIdentifySpecimenRepository toIdentifySpecimenRepository;

    private Random r = new Random();

    public Page<Specimen> getSpecimens(Pageable pageable) {
        return repository.findAll(pageable);
    }

    public List<Specimen> getSpecimens() {
        return repository.findAll();
    }

    public Specimen getSpecimenById(long id) {
        return repository.findById((long)id);
    }

    public Specimen saveSpecimen(Specimen specimen){
        return repository.save(specimen);
    }

    public String deleteSpecimen(long id) {
        repository.deleteById(id);
        return "Specimen with id="+ id +" removed!";
    }

    public Long getSpecimenCount() {
        return repository.count();
    }


    public List<SpecimenQuizDTO> getQuizSpecimens( Set<Long> answeredQuizzesIds, int noReferenceSpecimens, int noToIdentifySpecimens ){
        List<SpecimenQuizDTO> specimens = new ArrayList<>();

        List<Long> idsReference = referenceSpecimenRepository.findAllIds();
        List<Long> idsToIdentify = toIdentifySpecimenRepository.findAllIds();

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


            entry = repository.findById(idsReference.get(entryId));

            if(entry.isPresent()){

                refCounter++;

                idsReference.remove(entryId);
                specimens.add( new SpecimenQuizDTO(entry.get() ) );
            }
        }

        while(toIdenCounter < noToIdentifySpecimens ){

            entryId =  this.r.nextInt(idsToIdentify.size());

            entry = repository.findById(idsToIdentify.get( entryId) );

            if(entry.isPresent()){
                toIdenCounter++;

                idsToIdentify.remove(entryId);
                specimens.add( new SpecimenQuizDTO(entry.get() ) );
            }
        }


        return specimens;
    }
}
