package com.camellia.models.users;

import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.camellia.models.Quiz;
import com.camellia.models.specimens.Specimen;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.NoArgsConstructor;


@Entity
@NoArgsConstructor
@DiscriminatorValue("REGISTERED")
public class RegisteredUser extends User{


    @Column(name = "auto_approval", nullable = false)
    private boolean autoApproval;


    public boolean isAutoApproval() {
        return this.autoApproval;
    }

    public boolean getAutoApproval() {
        return this.autoApproval;
    }

    public void setAutoApproval(boolean autoApproval) {
        this.autoApproval = autoApproval;
    }
   

    public String profile() {
        return "{" + super.profile() + 
            ", " + "\"auto_approval\":" + isAutoApproval()  +
            "}";
    }
    
}
