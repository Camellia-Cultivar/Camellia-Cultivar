package com.camellia.models.users;


import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Getter
@Setter
@NoArgsConstructor
//@Table(name = "administrator_user")
@DiscriminatorValue("ADMIN")
public class AdministratorUser extends User{
    

}
