package com.f1.repo;
import com.f1.domain.*;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.*;


public interface RaceRepository extends JpaRepository<Race, Long> {
  List<Race> findBySeasonIdOrderByRoundAsc(Long seasonId);
}

