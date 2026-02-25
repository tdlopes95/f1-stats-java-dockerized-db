package com.f1.api;


import com.f1.dto.*;
import com.f1.domain.*;
import com.f1.repo.*;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;

@RestController
@RequestMapping("/api")
public class CoreController {
  private final DriverRepository driverRepo;
  private final SeasonRepository seasonRepo;
  private final RaceRepository raceRepo;
  private final TeamRepository teamRepo;
  private final DriverTeamMembershipRepository membershipRepo;
  private final RaceSessionRepository sessionRepo;
  private final SessionResultRepository resultRepo;

  public CoreController(
      DriverRepository d, SeasonRepository s, RaceRepository r, TeamRepository t,
      DriverTeamMembershipRepository m, RaceSessionRepository rs, SessionResultRepository rr) {
    this.driverRepo = d; this.seasonRepo = s; this.raceRepo = r; this.teamRepo = t;
    this.membershipRepo = m; this.sessionRepo = rs; this.resultRepo = rr;
  }

  @PostMapping("/drivers")
  public ResponseEntity<Driver> createDriver(@RequestBody CreateDriverRequest req) {
    return ResponseEntity.status(HttpStatus.CREATED).body(driverRepo.save(new Driver(req.name())));
  }

  @PostMapping("/seasons")
  public ResponseEntity<Season> createSeason(@RequestBody CreateSeasonRequest req) {
    return ResponseEntity.status(HttpStatus.CREATED).body(seasonRepo.save(new Season(req.year())));
  }

  @PostMapping("/races")
  public ResponseEntity<Race> createRace(@RequestBody CreateRaceRequest req) {
    Season s = seasonRepo.findById(req.seasonId()).orElseThrow();
    
    Race r = new Race(
      s,
      req.name(),
      (req.raceDate() != null ? LocalDate.parse(req.raceDate()) : null),
      req.round()
    );

    return ResponseEntity.status(HttpStatus.CREATED).body(raceRepo.save(r));
  }

  @PostMapping("/memberships")
  public ResponseEntity<DriverTeamMembership> assignMembership(@RequestBody AssignDriverToTeamForSeasonRequest req) {
    Driver d = driverRepo.findById(req.driverId()).orElseThrow();
    Team t = teamRepo.findById(req.teamId()).orElseThrow();
    Season s = seasonRepo.findById(req.seasonId()).orElseThrow();
    return ResponseEntity.status(HttpStatus.CREATED).body(membershipRepo.save(new DriverTeamMembership(d, t, s)));
  }

  // Create a session (RACE or SPRINT)
  @PostMapping("/race-sessions")
  public ResponseEntity<RaceSession> createRaceSession(@RequestBody CreateRaceSessionRequest req) {
    Race race = raceRepo.findById(req.raceId()).orElseThrow();
    SessionType type = SessionType.valueOf(req.sessionType().toUpperCase());
    RaceSession session = new RaceSession(
        race,
        type,
        req.sessionNo() != null ? req.sessionNo() : 1,
        req.sessionDate() != null ? LocalDate.parse(req.sessionDate()) : race.getRaceDate()
    );
    return ResponseEntity.status(HttpStatus.CREATED).body(sessionRepo.save(session));
  }

  // Add a result to a session. Snapshot the team from membership unless overridden.
  @PostMapping("/session-results")
  public ResponseEntity<SessionResult> createSessionResult(@RequestBody CreateSessionResultRequest req) {
    Driver d = driverRepo.findById(req.driverId()).orElseThrow();
    RaceSession session = sessionRepo.findById(req.sessionId()).orElseThrow();
    Team team;

    if (req.teamId() != null) {
      team = teamRepo.findById(req.teamId()).orElseThrow();
    } else {
      Long seasonId = session.getRace().getSeason().getId();
      team = membershipRepo.findByDriverIdAndSeasonId(d.getId(), seasonId)
              .map(DriverTeamMembership::getTeam)
              .orElseThrow(() -> new IllegalArgumentException("No team membership for driver in this season"));
    }

    SessionResult sr = new SessionResult(d, session, team, req.position(), req.points());
    return ResponseEntity.status(HttpStatus.CREATED).body(resultRepo.save(sr));
  }
}

