package com.f1.api;

import com.f1.dto.SeasonDto;
import com.f1.repo.SeasonRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Sort;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api")
@RequiredArgsConstructor
public class SeasonQueryController {

  private final SeasonRepository seasonRepository;

  /** GET /api/seasons  ->  [{ id, year }, ...] */
  @GetMapping("/seasons")
  public List<SeasonDto> listSeasons() {
    return seasonRepository.findAll(Sort.by("year"))
        .stream()
        .map(s -> new SeasonDto(s.getId(), s.getYear()))
        .toList();
  }
}