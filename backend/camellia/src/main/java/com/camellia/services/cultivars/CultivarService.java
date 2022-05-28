package com.camellia.services.cultivars;

import com.camellia.repositories.cultivars.CultivarRepository;
import com.camellia.models.cultivars.Cultivar;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Optional;


@Service
public class CultivarService {
    @Autowired
    private CultivarRepository repository;

    public Page<Cultivar> getCultivars(Pageable pageable) {
        return repository.findAll(pageable);
    }

    public List<Cultivar> getCultivars() {
        return repository.findAll();
    }

    public Optional<Cultivar> getCultivarById(Long id) {
        return repository.findById(id);
    }

    public Cultivar getCultivarByName(String name){
        return repository.findByName(name);
    }
}
