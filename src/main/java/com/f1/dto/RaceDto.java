package com.f1.dto;

import java.time.LocalDate;

public record RaceDto(Long id, Long seasonId, String name, LocalDate raceDate, Integer round) {}