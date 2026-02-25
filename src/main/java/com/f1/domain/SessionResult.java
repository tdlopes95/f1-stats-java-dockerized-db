package com.f1.domain;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(
    name="session_results",
    uniqueConstraints=@UniqueConstraint(columnNames={"driver_id","session_id"})
)
@Getter @Setter @NoArgsConstructor
public class SessionResult {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(optional=false)
    @JoinColumn(name="driver_id")
    private Driver driver;

    @ManyToOne(optional=false)
    @JoinColumn(name="session_id")
    private RaceSession session;

    @ManyToOne(optional=false)
    @JoinColumn(name="team_id")
    private Team team;

    private Integer position;  // 1-based ranking
    @Column(nullable=false)
    private Integer points;

    // Custom constructor for your controller to use
    public SessionResult(
        Driver driver,
        RaceSession session,
        Team team,
        Integer position,
        Integer points
    ) {
        this.driver = driver;
        this.session = session;
        this.team = team;
        this.position = position;
        this.points = points;
    }
}