package com.f1.dto;


public record CreateRaceSessionRequest(
  Long raceId,
  String sessionType, //"RACE" or "SPRINT"
  Integer sessionNo,
  String sessionDate
) {}

