package com.f1.api;


import com.f1.domain.*;
import com.f1.dto.*;
import com.f1.repo.*;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@RestController
@RequestMapping("/api/stats")
public class StatsController {
  private final SessionResultRepository resultRepo;
  private final DriverRepository driverRepo;
  private final TeamRepository teamRepo;
  private final SeasonRepository seasonRepo;

  public StatsController(SessionResultRepository r, DriverRepository d, TeamRepository t, SeasonRepository s) {
    this.resultRepo = r; this.driverRepo = d; this.teamRepo = t; this.seasonRepo = s;
  }

  // Averages per session (RACE and SPRINT)
  @GetMapping("/average-points-per-session")
  public List<Map<String,Object>> avgPointsPerSession() {
    List<Object[]> rows = resultRepo.averagePointsPerSession();
    List<Map<String,Object>> out = new ArrayList<>();
    for (Object[] r : rows) {
      out.add(Map.of("sessionId", r[0], "raceName", r[1], "sessionType", r[2], "avgPoints", r[3]));
    }
    return out;
  }

  @GetMapping("/average-points-per-session-by-team")
  public List<Map<String,Object>> avgPointsPerSessionByTeam() {
    List<Object[]> rows = resultRepo.averagePointsPerSessionByTeam();
    List<Map<String,Object>> out = new ArrayList<>();
    for (Object[] r : rows) {
      out.add(Map.of("sessionId", r[0], "raceName", r[1], "sessionType", r[2], "teamName", r[3], "avgPoints", r[4]));
    }
    return out;
  }

  // Driver summaries
  @GetMapping("/driver/{driverId}/summary")
  public DriverSummary driverSummary(@PathVariable Long driverId) {
    Driver d = driverRepo.findById(driverId).orElseThrow();
    Double avgPts = Optional.ofNullable(resultRepo.avgPointsForDriver(driverId)).orElse(0.0);
    Integer totalPts = Optional.ofNullable(resultRepo.totalPointsForDriver(driverId)).orElse(0);
    return new DriverSummary(driverId, d.getName(), avgPts, totalPts);
  }

  // Driver season summary (sum totals + RACE/SPRINT breakdown)
  @GetMapping("/driver/{driverId}/season/{seasonId}/summary")
  public DriverSeasonSummary driverSeasonSummary(@PathVariable Long driverId, @PathVariable Long seasonId) {
    Driver d = driverRepo.findById(driverId).orElseThrow();
    Season s = seasonRepo.findById(seasonId).orElseThrow();

    Double avgPts = Optional.ofNullable(resultRepo.avgPointsForDriverInSeason(driverId, seasonId)).orElse(0.0);
    Integer total = Optional.ofNullable(resultRepo.totalPointsForDriverInSeason(driverId, seasonId)).orElse(0);
    Integer racePts = Optional.ofNullable(resultRepo.totalPointsForDriverInSeasonByType(driverId, seasonId, SessionType.RACE)).orElse(0);
    Integer sprintPts = Optional.ofNullable(resultRepo.totalPointsForDriverInSeasonByType(driverId, seasonId, SessionType.SPRINT)).orElse(0);

    return new DriverSeasonSummary(driverId, d.getName(), seasonId, s.getYear(), avgPts, total, racePts, sprintPts);
  }

  // Season leaderboards (overall or by type)
  @GetMapping("/season/{seasonId}/team-leaderboard")
  public List<Map<String,Object>> teamLeaderboard(@PathVariable Long seasonId, @RequestParam(required=false) String type) {
    List<Object[]> rows = (type == null)
        ? resultRepo.teamLeaderboard(seasonId)
        : resultRepo.teamLeaderboardByType(seasonId, SessionType.valueOf(type.toUpperCase()));
    List<Map<String,Object>> out = new ArrayList<>();
    for (Object[] r : rows) out.add(Map.of("teamId", r[0], "teamName", r[1], "points", r[2]));
    return out;
  }

  @GetMapping("/season/{seasonId}/driver-leaderboard")
  public List<Map<String,Object>> driverLeaderboard(@PathVariable Long seasonId, @RequestParam(required=false) String type) {
    List<Object[]> rows = (type == null)
        ? resultRepo.driverLeaderboard(seasonId)
        : resultRepo.driverLeaderboardByType(seasonId, SessionType.valueOf(type.toUpperCase()));
    List<Map<String,Object>> out = new ArrayList<>();
    for (Object[] r : rows) out.add(Map.of("driverId", r[0], "driverName", r[1], "points", r[2]));
    return out;
  }

}

