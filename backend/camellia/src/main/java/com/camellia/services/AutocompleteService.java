package com.camellia.services;

import com.camellia.mappers.CultivarMapper;
import com.camellia.mappers.CultivarSynonymMapper;
import com.camellia.models.cultivars.CultivarDenominationDTO;
import com.camellia.repositories.cultivars.CultivarRepository;
import com.camellia.repositories.cultivars.CultivarSynonymsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class AutocompleteService {
    @Autowired
    private CultivarRepository cultivarRepository;

    @Autowired
    private CultivarSynonymsRepository synonymsRepository;

    public List<CultivarDenominationDTO> getAutocompleteSuggestions (String substring) {
        List<CultivarDenominationDTO> cultivars = cultivarRepository.findTop5ByEpithetStartsWithIgnoreCase(substring)
                .stream()
                .map(CultivarMapper.MAPPER::cultivarToCultivarDenominationDTO)
                .collect(Collectors.toList());

        List<CultivarDenominationDTO> synonyms = synonymsRepository.findTop5BySynonymStartsWithIgnoreCase(substring)
                .stream()
                .map(CultivarSynonymMapper.MAPPER::synonymToCultivarDenominationDTO)
                .collect(Collectors.toList());

        cultivars.addAll(synonyms);
        cultivars.sort(Comparator.comparing(CultivarDenominationDTO::getDenomination));

        return cultivars.subList(0, Math.min(5, cultivars.size()));
    }

}
