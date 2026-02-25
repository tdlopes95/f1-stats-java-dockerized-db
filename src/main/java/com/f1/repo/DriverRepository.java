package com.f1.repo;
import com.f1.domain.*;
import org.springframework.data.jpa.repository.JpaRepository;


public interface DriverRepository extends JpaRepository<Driver, Long> {}
