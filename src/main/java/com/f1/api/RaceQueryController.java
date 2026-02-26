package com.f1.api;

import com.f1.dto.RaceDto;
import com.f1.dto.RaceSessionDto;
import com.f1.dto.SessionResultRow;
import com.f1.domain.Race;
import com.f1.domain.RaceSession;
import com.f1.repo.RaceRepository;
import com.f1.repo.RaceSessionRepository;
import com.f1.repo.SessionResultRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api")
@RequiredArgsConstructor
public class RaceQueryController {

  private final RaceRepository raceRepo;
  private final RaceSessionRepository sessionRepo;
  private final SessionResultRepository resultRepo;

  /** GET /api/season/{seasonId}/races -> races ordered by round */
  @GetMapping("/season/{seasonId}/races")
  public List<RaceDto> racesInSeason(@PathVariable("seasonId") Long seasonId) {
    return raceRepo.findBySeasonIdOrderByRoundAsc(seasonId)
        .stream()
        .map(r -> new RaceDto(r.getId(), r.getSeason().getId(), r.getName(), r.getRaceDate(), r.getRound()))
        .toList();
  }

  /** GET /api/race/{id} -> 1 race */
  @GetMapping("/race/{id}")
  public ResponseEntity<RaceDto> getRace(@PathVariable("id") Long id) {
    return raceRepo.findById(id)
        .map(r -> new RaceDto(r.getId(), r.getSeason().getId(), r.getName(), r.getRaceDate(), r.getRound()))
        .map(ResponseEntity::ok)
        .orElse(ResponseEntity.notFound().build());
  }

  /** GET /api/race/{id}/sessions -> list of Race / Sprint for that race */
  @GetMapping("/race/{id}/sessions")
  public List<RaceSessionDto> getRaceSessions(@PathVariable("id") Long id) {
    List<RaceSession> list = sessionRepo.findByRaceIdOrderBySessionTypeAscSessionNoAsc(id);
    return list.stream()
        .map(rs -> new RaceSessionDto(
            rs.getId(),
            rs.getRace().getId(),
            rs.getSessionType().name(),
            rs.getSessionNo(),
            rs.getSessionDate()))
        .toList();
  }

  /** GET /api/race-session/{sessionId}/results -> driver, team, position, points */
  @GetMapping("/race-session/{sessionId}/results")
  public List<SessionResultRow> getSessionResults(@PathVariable("sessionId") Long sessionId) {
    return resultRepo.findRowsBySessionId(sessionId);
  }
}