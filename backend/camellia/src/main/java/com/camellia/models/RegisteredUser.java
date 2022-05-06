package com.camellia.models;

import javax.persistence.Column;

public class RegisteredUser {

    
    @Column(name = "reputation", nullable = false)
    private double reputation;

    @Column(name = "verified", nullable = false)
    private boolean verified;

    @Column(name = "auto_approval", nullable = false)
    private boolean auto_approval;

    
}
