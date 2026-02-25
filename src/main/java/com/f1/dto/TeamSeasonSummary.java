package com.f1.dto;

public record TeamSeasonSummary(
  Long teamId, String teamName, Long seasonId, Integer seasonYear,
  Integer totalPoints, Integer totalRacePoints, Integer totalSprintPoints
) {}

