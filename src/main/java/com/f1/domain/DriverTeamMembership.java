// DriverTeamMembership.java
package com.f1.domain;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Getter @Setter @NoArgsConstructor
@Table(name = "driver_team_memberships", uniqueConstraints = {
    @UniqueConstraint(columnNames = {"driver_id", "season_id"})
})
public class DriverTeamMembership {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(optional = false) @JoinColumn(name = "driver_id")
    private Driver driver;

    @ManyToOne(optional = false) @JoinColumn(name = "team_id")
    private Team team;

    @ManyToOne(optional = false) @JoinColumn(name = "season_id")
    private Season season;

    public DriverTeamMembership(Driver driver, Team team, Season season) {
        this.driver = driver;
        this.team = team;
        this.season = season;
    }
}
