package com.camellia.controllers;

import com.camellia.services.specimens.SpecimenService;
import com.camellia.services.users.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/public/achievements")
public class AchievementsController {

    @Autowired
    private SpecimenService specimenService;

    @Autowired
    private UserService userService;

    @GetMapping
    public Map<String, Long> getAchievements() {

        HashMap<String, Long> achievements = new HashMap<>();
        achievements.put("specimenCount", specimenService.getSpecimenCount());
        achievements.put("userCount", userService.getUserCount());
        achievements.put("photoCount", specimenService.getSpecimenPhotosCount());

        return achievements;
    }


}
