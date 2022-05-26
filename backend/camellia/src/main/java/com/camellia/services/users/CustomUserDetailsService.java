package com.camellia.services.users;

import javax.transaction.Transactional;

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
        UserDetails userDetails = org.springframework.security.core.userdetails.User.withUsername(user.getEmail())
                .password(user.getPassword())
                .authorities(getAuthorities(user)).build()
                ;

        return userDetails;
    }

    private GrantedAuthority getAuthorities(User user){
        return new SimpleGrantedAuthority(user.getDecriminatorValue());
    }
}
