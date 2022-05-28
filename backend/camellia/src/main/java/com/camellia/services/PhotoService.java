package com.camellia.services;

import com.camellia.models.Photo;
import com.camellia.repositories.PhotoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PhotoService {
    @Autowired
    PhotoRepository photoRepository;

    public Photo getPhotoById(Long id) {
        return photoRepository.getPhotoByPhotoId(id);
    }

    public Long getPhotoCount() {
        return photoRepository.count();
    }
}
