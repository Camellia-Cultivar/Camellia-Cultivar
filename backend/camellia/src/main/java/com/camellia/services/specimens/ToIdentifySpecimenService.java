package com.camellia.services.specimens;

import com.camellia.mappers.SpecimenMapper;
import com.camellia.models.characteristics.CharacteristicValue;
import com.camellia.models.cultivars.Cultivar;
import com.camellia.models.specimens.Specimen;
import com.camellia.models.specimens.SpecimenDto;
import com.camellia.models.users.User;
import com.camellia.repositories.specimens.SpecimenRepository;
import com.camellia.services.users.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.io.UnsupportedEncodingException;
import java.util.*;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

@Service
public class ToIdentifySpecimenService {
    @Autowired
    private SpecimenRepository specimenRepository;

    @Autowired
    private UserService userService;

    @Autowired
    private JavaMailSender mailSender;

    public Page<Specimen> getToIdentifySpecimens(Pageable pageable) {
        return specimenRepository.findAllToIdentify(pageable);
    }

    public List<Specimen> getToIdentifySpecimens() {
        return specimenRepository.findAllToIdentify();
    }

    public Specimen getToIdentifySpecimenById(long id) {
        return specimenRepository.findToIdentifyById(id);
    }

    public void updateVotes(Specimen specimen, Map<Cultivar, Double> votes){
        specimen.setCultivarProbabilities(votes);
    }

    public List<Specimen> getRecentlyUploaded() {
        return specimenRepository.findAllToIdentifyBy(
                PageRequest.of(0, 10, Sort.by("specimenId").descending())
        );
    }

    public SpecimenDto promoteToReferenceFromId(long id, Cultivar c) throws MailException, UnsupportedEncodingException, MessagingException {
        Specimen promotingSpecimen = this.getToIdentifySpecimenById(id);
        return promoteToReference(promotingSpecimen, c);
    }


    public SpecimenDto promoteToReference(Specimen promotingSpecimen, Cultivar c) throws MailException, UnsupportedEncodingException, MessagingException {
        if (promotingSpecimen == null)
            return null;

        promotingSpecimen.promoteToReference();
        promotingSpecimen.setCultivar(c);

        if(c.getCharacteristicValues().isEmpty()){
            Iterator<CharacteristicValue> it =  promotingSpecimen.getCharacteristicValues().iterator();
            List<CharacteristicValue> list = new ArrayList<>();
            while(it.hasNext())
                list.add(it.next());
            System.out.println(list);
            c.setCharacteristicValues(list);
        }
        specimenRepository.saveAndFlush(promotingSpecimen);


        sendSpecimneIdentifiedEmail(promotingSpecimen);

        return SpecimenMapper.MAPPER.specimenToSpecimenDTO(promotingSpecimen);
    }



    private void sendSpecimneIdentifiedEmail(Specimen s)
        throws MailException, UnsupportedEncodingException, MessagingException {
       
        User user = userService.getUserById( specimenRepository.findUserById(s.getSpecimenId()) );

        String toAddress = user.getEmail();
        String fromAddress = "camelliacultivar@gmail.com";
        String senderName = "Cammelia Cultivar";
        String subject = "Specimen Identified";
        String content = "Dear user,"
                + "One of your specimens has been identified. Get back on the app to check it.<br>"
                + "Thank you,<br>"
                + "Cammelia Cultivar";
        
        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message);
        
        helper.setFrom(fromAddress, senderName);
        helper.setTo(toAddress);
        helper.setSubject(subject);
                        
        helper.setText(content, true);
        
        mailSender.send(message);
        
    }
}
