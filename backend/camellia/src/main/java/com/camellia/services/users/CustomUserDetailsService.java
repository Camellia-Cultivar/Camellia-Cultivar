package com.camellia.services.users;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Set;

import javax.transaction.Transactional;

import com.camellia.models.users.Role;
import com.camellia.models.users.User;
import com.camellia.repositories.users.UserRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Service;

@Transactional
@Service("userDetailsService")
public class CustomUserDetailsService implements UserDetailsService{
    @Autowired
    UserRepository userRepository;

    @Override
    public UserDetails loadUserByUsername(String email) {
        final User user = userRepository.findByEmail(email);
        if (user == null) {
            return null;
        }
        return org.springframework.security.core.userdetails.User.withUsername(user.getEmail())
                .password(user.getPassword())
                .authorities(getAuthorities(user))
                .build()
                ;

    }

    
    private Collection<GrantedAuthority> getAuthorities(User user){
        Set<Role> roles = user.getRoles();
        Collection<GrantedAuthority> authorities = new ArrayList<>();
         
        for (Role role : roles) {
            authorities.add(new SimpleGrantedAuthority(role.getName()));
        }
        return authorities;
    }
    
}
