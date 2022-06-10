package com.camellia.models.users;


import javax.persistence.Column;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;


import lombok.NoArgsConstructor;


@Entity
@NoArgsConstructor
@DiscriminatorValue("REGISTERED")
public class RegisteredUser extends User{

    
}
