package com.f1.repo;
import com.f1.domain.*;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.*;


public interface DriverTeamMembershipRepository extends JpaRepository<DriverTeamMembership, Long> {
  Optional<DriverTeamMembership> findByDriverIdAndSeasonId(Long driverId, Long seasonId);
}

