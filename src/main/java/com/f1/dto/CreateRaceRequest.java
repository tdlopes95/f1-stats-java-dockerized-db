package com.f1.dto;

public record CreateRaceRequest(Long seasonId, String name, String raceDate, Integer round) {}