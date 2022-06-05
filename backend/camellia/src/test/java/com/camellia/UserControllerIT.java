package com.camellia;

import org.aspectj.lang.annotation.Before;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.context.SpringBootTest.WebEnvironment;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.boot.web.server.LocalServerPort;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import com.camellia.models.users.RegisteredUser;
import com.camellia.models.users.User;
import com.camellia.repositories.users.UserRepository;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest(webEnvironment = WebEnvironment.RANDOM_PORT)

@AutoConfigureTestDatabase
public class UserControllerIT {
    
    @LocalServerPort
    int randomServerPort;

    @Autowired
    private TestRestTemplate restTemplateWithTrustStore;

    @Autowired
    private UserRepository repository;

    @BeforeEach
    public void resetDb() {
        repository.deleteAll();
    }


//    @Test
//    public void whenValidInput_thenCreateUser() {
//        User vitor = new RegisteredUser();
//        vitor.setFirstName("vitor");
//        vitor.setLastName("vitor");
//        vitor.setEmail("vfrd00@gmail.com");
//        vitor.setPassword("vitor");
//        //vitor.setProfilePhoto(profilePhoto);
//        ResponseEntity<User> entity = restTemplateWithTrustStore.postForEntity("/api/users/signup", vitor, User.class);
//        System.out.println(entity);
//        List<User> found = repository.findAll();
//        System.out.println(found.get(0).getDecriminatorValue());
//        assertThat(found).contains(vitor);
//    }

//    @Test
//     void givenEmployees_whenGetEmployees_thenStatus200()  {
//        createTestEmployee("bob", "bob@deti.com");
//        createTestEmployee("alex", "alex@deti.com");
//
//
//        ResponseEntity<List<Employee>> response = restTemplate
//                .exchange("/api/employees", HttpMethod.GET, null, new ParameterizedTypeReference<List<Employee>>() {
//                });
//
//        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
//        assertThat(response.getBody()).extracting(Employee::getName).containsExactly("bob", "alex");
//
//    }
//
//
//    private void createTestEmployee(String name, String email) {
//        Employee emp = new Employee(name, email);
//        repository.saveAndFlush(emp);
//    }
}
