package com.f1.repo;
import com.f1.domain.*;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.*;


public interface SeasonRepository extends JpaRepository<Season, Long> {
  Optional<Season> findByYear(Integer year);
}
