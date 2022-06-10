package com.camellia.services.cultivars;

import com.camellia.mappers.CultivarMapper;
import com.camellia.models.cultivars.Cultivar;
import com.camellia.repositories.cultivars.CultivarRepository;
import com.camellia.views.CultivarListView;
import com.camellia.models.cultivars.CultivarDTO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Optional;


@Service
public class CultivarService {

    public static final long CULTIVARS_PER_PAGE = 9;

    @Autowired
    private CultivarRepository repository;

    public Page<Cultivar> getCultivars(Pageable pageable) {
        return repository.findAll(pageable);
    }

    public List<CultivarListView> getCultivars(long page) {
        page -= 1;
        page = page * CULTIVARS_PER_PAGE;
        return repository.retrieveAllPaged(page , CULTIVARS_PER_PAGE);
    }

    public CultivarDTO getCultivarDTOById(Long id) {
        Optional<Cultivar> c = repository.findById(id);
        if(c.isPresent())
            return CultivarMapper.MAPPER.cultivarToCultivarDTO(c.get());
        return new CultivarDTO();
    }

    public Cultivar getCultivarById(Long id) {
        Optional<Cultivar> c = repository.findById(id);
        if(c.isPresent())
            return c.get();
        return new Cultivar();
    }

    public Cultivar getCultivarByEpithet(String epithet){
        return repository.findByEpithet(epithet);
    }

    public Cultivar createCultivar(CultivarDTO cultivar){
        Cultivar c = new Cultivar();
        c.setEpithet(cultivar.getEpithet());
        c.setDescription(cultivar.getDescription());
        c.setPhotograph(cultivar.getPhotograph());
        c.setSpecies(cultivar.getSpecies());

        return repository.save(c);
    }
}
