package com.camellia.services.users;

import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import com.camellia.models.users.RegisteredUser;
import com.camellia.repositories.users.RegisteredUserRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import net.bytebuddy.utility.RandomString;



@Service
public class RegisteredUserService {
    @Autowired
    private RegisteredUserRepository repository;

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    @Autowired
    private JavaMailSender mailSender;

    public ResponseEntity<String> addRegisteredUser( RegisteredUser user, String siteUrl) throws MailException, UnsupportedEncodingException, MessagingException{
        if( user.getFirstName().isEmpty() || user.getLastName().isEmpty() 
                    || user.getPassword().isEmpty() || user.getEmail().isEmpty())
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Invalid user data");
        
        user.setAutoApproval(false);
        user.setReputation(0.0);

        try{
            if(repository.findByEmail(user.getEmail()) != null){
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("User already exists");

            }
            user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));

            String randomCode = RandomString.make(64);
            user.setVerificationCode(randomCode);
            user.setVerified(false);

            this.repository.save(user);


            sendRegistrationEmail( user, siteUrl);

        } catch(  DataIntegrityViolationException | NullPointerException e){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Invalid data. User was not created");
        }
        
        
        return ResponseEntity.status(HttpStatus.CREATED).body("User Added");
    }

    public ResponseEntity<String> getUserProfile(long id){
        return ResponseEntity.status(HttpStatus.ACCEPTED).body(this.repository.findById(id).getProfile());
    }

    public Page<RegisteredUser> getRegisteredUsers(Pageable pageable) {
        return repository.findAll(pageable);
    }

    public List<RegisteredUser> getRegisteredUsers() {
        return repository.findAll();
    }

    public RegisteredUser getRegisteredUserById(long id) {
        return repository.findById( id);
    }

    public String editProfile(RegisteredUser tempUser){
        RegisteredUser user = this.repository.findByEmail(tempUser.getEmail());
        if( !tempUser.getProfilePhoto().isEmpty())
            user.setProfilePhoto(tempUser.getProfilePhoto());
        if( !tempUser.getFirstName().isEmpty())
            user.setFirstName(tempUser.getFirstName());
        if( !tempUser.getLastName().isEmpty())  
            user.setLastName(tempUser.getLastName());
        if( !tempUser.getPassword().isEmpty())
            user.setPassword(bCryptPasswordEncoder.encode(tempUser.getPassword()));


        this.repository.save(user);
        return user.getProfile();
    }

    private void sendRegistrationEmail(RegisteredUser user, String siteURL)
        throws MailException, UnsupportedEncodingException, MessagingException {
       
        String toAddress = user.getEmail();
        String fromAddress = "camelliacultivar@gmail.com";
        String senderName = "Cammelia Cultivar";
        String subject = "Please verify your registration";
        String content = "Dear [[name]],<br>"
                + "Please click the link below to verify your registration:<br>"
                + "<h3><a href=\"[[URL]]\" target=\"_self\">VERIFY</a></h3>"
                + "Thank you,<br>"
                + "Cammelia Cultivar";
        
        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message);
        
        helper.setFrom(fromAddress, senderName);
        helper.setTo(toAddress);
        helper.setSubject(subject);
        
        content = content.replace("[[name]]", user.getFirstName().concat(" ").concat(user.getLastName()));
        String verifyURL = siteURL + "/api/users/verify?code=" + user.getVerificationCode();
        
        content = content.replace("[[URL]]", verifyURL);
        
        helper.setText(content, true);
        
        mailSender.send(message);
        
    }
}
