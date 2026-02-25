// RaceSession.java
package com.f1.domain;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;

@Entity
@Table(name = "race_sessions")
@Getter @Setter @NoArgsConstructor
public class RaceSession {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(optional = false) @JoinColumn(name = "race_id")
    private Race race;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private SessionType sessionType;

    @Column(nullable = false)
    private Integer sessionNo;

    private LocalDate sessionDate;

    public RaceSession(Race race, SessionType sessionType, Integer sessionNo, LocalDate sessionDate) {
        this.race = race;
        this.sessionType = sessionType;
        this.sessionNo = sessionNo;
        this.sessionDate = sessionDate;
    }
}
