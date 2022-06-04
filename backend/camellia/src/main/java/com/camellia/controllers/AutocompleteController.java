package com.camellia.controllers;

import com.camellia.models.cultivars.CultivarDenominationDTO;
import com.camellia.services.AutocompleteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/autocomplete")
public class AutocompleteController {

    @Autowired
    private AutocompleteService autocompleteService;

    @GetMapping
    public List<CultivarDenominationDTO> getAutocompleteSuggestions(@RequestParam String substring) {
        return autocompleteService.getAutocompleteSuggestions(substring);
    }
}
