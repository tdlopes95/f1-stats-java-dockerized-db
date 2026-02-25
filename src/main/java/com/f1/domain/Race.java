// Race.java
package com.f1.domain;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;

@Entity
@Table(name = "races")
@Getter @Setter @NoArgsConstructor
public class Race {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(optional = false)
    @JoinColumn(name = "season_id")
    private Season season;

    @Column(nullable = false)
    private String name;

    private LocalDate raceDate;   // !!!! make sure the field is named like this
    private Integer round;

    public Race(Season season, String name, LocalDate raceDate, Integer round) {
        this.season = season;
        this.name = name;
        this.raceDate = raceDate;
        this.round = round;
    }
}