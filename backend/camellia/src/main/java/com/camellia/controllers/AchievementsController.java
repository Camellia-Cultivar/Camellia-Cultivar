package com.camellia.controllers;

import com.camellia.services.PhotoService;
import com.camellia.services.specimens.SpecimenService;
import com.camellia.services.users.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/achievements")
public class AchievementsController {

    @Autowired
    private SpecimenService specimenService;

    @Autowired
    private UserService userService;

    @Autowired
    private PhotoService photoService;

    @GetMapping
    public Map<String, Long> getAchievements() {

        HashMap<String, Long> achievements = new HashMap<>();
        achievements.put("specimenCount", specimenService.getSpecimenCount());
        achievements.put("userCount", userService.getUserCount());
        achievements.put("photoCount", photoService.getPhotoCount());

        return achievements;
    }


}
