package com.camellia.services;

import com.camellia.repositories.CultivarRepository;
import com.camellia.models.Cultivar;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;


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

    public Cultivar getCultivarById(long id) {
        return repository.findById((long) id);
    }
}
