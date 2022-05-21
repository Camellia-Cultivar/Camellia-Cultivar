package com.camellia.models.users;

import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.camellia.models.requests.CultivarRequest;
import com.camellia.models.requests.IdentificationRequest;
import com.camellia.models.requests.ReportRequest;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

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
