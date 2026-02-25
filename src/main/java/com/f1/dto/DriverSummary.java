package com.f1.dto;

public record DriverSummary(
  Long driverId, String driverName,
  Double averagePoints, Integer totalPoints
) {}



