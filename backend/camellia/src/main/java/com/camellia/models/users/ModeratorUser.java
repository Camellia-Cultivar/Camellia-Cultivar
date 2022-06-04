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
//@Table(name = "moderator_user")
@DiscriminatorValue("MODERATOR")
public class ModeratorUser extends User{
    
}
