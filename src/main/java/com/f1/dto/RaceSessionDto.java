package com.f1.dto;

import java.time.LocalDate;

public record RaceSessionDto(Long id, Long raceId, String sessionType, Integer sessionNo, LocalDate sessionDate) {}