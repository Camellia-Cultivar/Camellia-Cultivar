package com.camellia.repositories.cultivars;

import com.camellia.models.cultivars.Cultivar;
import com.camellia.models.cultivars.CultivarDTO;
import com.camellia.views.CultivarListView;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;
import org.springframework.stereotype.Repository;

@Repository
public interface CultivarRepository extends JpaRepository<Cultivar, Long>{
    
    Optional<Cultivar> findById(Long id);

    List<Cultivar> findTop5ByEpithetStartsWithIgnoreCase(String subString);

    Cultivar findByEpithet(String epithet);

    @Query(value="SELECT cultivar_id, epithet, species, photograph FROM cultivar LIMIT :noPerPage OFFSET :page", nativeQuery=true)
    List<CultivarListView> retrieveAllPaged(@Param("page")  long page, @Param("noPerPage") long noPerPage);
}
