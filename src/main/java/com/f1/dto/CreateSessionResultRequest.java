package com.f1.dto;


public record CreateSessionResultRequest(
  Long driverId, Long sessionId,
  Integer position, Integer points, Integer lapTimeMs,
  Long teamId /* optional override */
) {}

