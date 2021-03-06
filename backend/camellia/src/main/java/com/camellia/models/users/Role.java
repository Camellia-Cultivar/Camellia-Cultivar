package com.camellia.models.users;

import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

@Entity
@Table(name="role")
public class Role {
 
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @Column(name="name")
    private String name;

    @ManyToMany(mappedBy = "roles")
    private Set<User> users;

    public Long getId(){
        return this.id;
    }

    public String getName(){
        return this.name;
    }

    @Override
    public String toString() {
        return name;
    }
}
