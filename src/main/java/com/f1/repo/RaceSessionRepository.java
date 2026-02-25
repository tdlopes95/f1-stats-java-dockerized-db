package com.f1.repo;
import com.f1.domain.*;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.*;


public interface RaceSessionRepository extends JpaRepository<RaceSession, Long> {
  List<RaceSession> findByRaceId(Long raceId);
  List<RaceSession> findByRaceIdAndSessionType(Long raceId, SessionType sessionType);
}
