// SessionResultRepository.java
package com.f1.repo;

import com.f1.domain.SessionResult;
import com.f1.domain.SessionType;
import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface SessionResultRepository extends JpaRepository<SessionResult, Long> {

  // Average points per session (all sessions)
  @Query("""
    SELECT sr.session.id, sr.session.race.name, sr.session.sessionType, AVG(sr.points)
    FROM SessionResult sr
    GROUP BY sr.session.id, sr.session.race.name, sr.session.sessionType
    ORDER BY sr.session.id
  """)
  List<Object[]> averagePointsPerSession();

  // Average points per session by team
  @Query("""
    SELECT sr.session.id, sr.session.race.name, sr.session.sessionType, sr.team.name, AVG(sr.points)
    FROM SessionResult sr
    GROUP BY sr.session.id, sr.session.race.name, sr.session.sessionType, sr.team.name
    ORDER BY sr.session.id, sr.team.name
  """)
  List<Object[]> averagePointsPerSessionByTeam();

  // Filters by type (RACE / SPRINT)
  @Query("""
    SELECT AVG(sr.points) FROM SessionResult sr
    WHERE sr.driver.id=:driverId AND sr.session.sessionType=:type
  """)
  Double avgPointsForDriverByType(@Param("driverId") Long driverId, @Param("type") SessionType type);

  @Query("""
    SELECT SUM(sr.points) FROM SessionResult sr
    WHERE sr.driver.id=:driverId AND sr.session.sessionType=:type
  """)
  Integer totalPointsForDriverByType(@Param("driverId") Long driverId, @Param("type") SessionType type);

  // Overall (all sessions)
  @Query("SELECT AVG(sr.points) FROM SessionResult sr WHERE sr.driver.id=:driverId")
  Double avgPointsForDriver(@Param("driverId") Long driverId);

  @Query("SELECT SUM(sr.points) FROM SessionResult sr WHERE sr.driver.id=:driverId")
  Integer totalPointsForDriver(@Param("driverId") Long driverId);

  // ===== Season-scoped =====
  @Query("""
    SELECT SUM(sr.points) FROM SessionResult sr
    WHERE sr.driver.id=:driverId AND sr.session.race.season.id=:seasonId
  """)
  Integer totalPointsForDriverInSeason(@Param("driverId") Long driverId, @Param("seasonId") Long seasonId);

  @Query("""
    SELECT SUM(sr.points) FROM SessionResult sr
    WHERE sr.driver.id=:driverId AND sr.session.race.season.id=:seasonId AND sr.session.sessionType=:type
  """)
  Integer totalPointsForDriverInSeasonByType(@Param("driverId") Long driverId, @Param("seasonId") Long seasonId, @Param("type") SessionType type);

  @Query("""
    SELECT AVG(sr.points) FROM SessionResult sr
    WHERE sr.driver.id=:driverId AND sr.session.race.season.id=:seasonId
  """)
  Double avgPointsForDriverInSeason(@Param("driverId") Long driverId, @Param("seasonId") Long seasonId);

  // Team season leaderboards
  @Query("""
    SELECT sr.team.id, sr.team.name, SUM(sr.points) AS pts
    FROM SessionResult sr
    WHERE sr.session.race.season.id=:seasonId
    GROUP BY sr.team.id, sr.team.name
    ORDER BY pts DESC
  """)
  List<Object[]> teamLeaderboard(@Param("seasonId") Long seasonId);

  @Query("""
    SELECT sr.team.id, sr.team.name, SUM(sr.points) AS pts
    FROM SessionResult sr
    WHERE sr.session.race.season.id=:seasonId AND sr.session.sessionType=:type
    GROUP BY sr.team.id, sr.team.name
    ORDER BY pts DESC
  """)
  List<Object[]> teamLeaderboardByType(@Param("seasonId") Long seasonId, @Param("type") SessionType type);

  // Driver season leaderboards
  @Query("""
    SELECT sr.driver.id, sr.driver.name, SUM(sr.points) AS pts
    FROM SessionResult sr
    WHERE sr.session.race.season.id=:seasonId
    GROUP BY sr.driver.id, sr.driver.name
    ORDER BY pts DESC
  """)
  List<Object[]> driverLeaderboard(@Param("seasonId") Long seasonId);

  @Query("""
    SELECT sr.driver.id, sr.driver.name, SUM(sr.points) AS pts
    FROM SessionResult sr
    WHERE sr.session.race.season.id=:seasonId AND sr.session.sessionType=:type
    GROUP BY sr.driver.id, sr.driver.name
    ORDER BY pts DESC
  """)
  List<Object[]> driverLeaderboardByType(@Param("seasonId") Long seasonId, @Param("type") SessionType type);

}