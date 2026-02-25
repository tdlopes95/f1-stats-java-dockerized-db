package com.f1.api;


import com.f1.dto.CreateTeamRequest;
import com.f1.domain.Team;
import com.f1.repo.TeamRepository;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/teams")
public class TeamController {
  private final TeamRepository teamRepo;
  public TeamController(TeamRepository teamRepo) { this.teamRepo = teamRepo; }

  @PostMapping
  public ResponseEntity<Team> createTeam(@RequestBody CreateTeamRequest req) {
    return ResponseEntity.status(HttpStatus.CREATED).body(teamRepo.save(new Team(req.name())));
  }
  @GetMapping public List<Team> list() { return teamRepo.findAll(); }
  @GetMapping("/{id}") public Team get(@PathVariable Long id) { return teamRepo.findById(id).orElseThrow(); }
}

