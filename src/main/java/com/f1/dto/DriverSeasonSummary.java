package com.f1.dto;

public record DriverSeasonSummary(
  Long driverId, String driverName, Long seasonId, Integer seasonYear,
  Double averagePoints, Integer totalPoints,
  Integer totalRacePoints, Integer totalSprintPoints
) {}



