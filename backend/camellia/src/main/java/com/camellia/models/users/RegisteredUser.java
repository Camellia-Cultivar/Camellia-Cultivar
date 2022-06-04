package com.camellia.models.users;


import javax.persistence.Column;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;


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
   

    public String getProfile() {
        return "{" + super.getProfile() + 
            ", " + "\"auto_approval\":" + isAutoApproval()  +
            "}";
    }
    
}
