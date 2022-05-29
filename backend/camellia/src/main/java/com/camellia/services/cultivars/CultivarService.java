package com.camellia.services.cultivars;

import com.camellia.repositories.cultivars.CultivarRepository;
import com.camellia.views.CultivarView;
import com.camellia.models.cultivars.Cultivar;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Optional;


@Service
public class CultivarService {

    public long CULTIVARS_PER_PAGE = 9;

    @Autowired
    private CultivarRepository repository;

    public Page<Cultivar> getCultivars(Pageable pageable) {
        return repository.findAll(pageable);
    }

    public List<CultivarView> getCultivars(long page) {
        page -= 1;
        page = page * CULTIVARS_PER_PAGE;
        return repository.retrieveAllPaged(page , CULTIVARS_PER_PAGE);
    }

    public Optional<Cultivar> getCultivarById(Long id) {
        return repository.findById(id);
    }

    public Cultivar getCultivarByEpithet(String epithet){
        return repository.findByEpithet(epithet);
    }
}
