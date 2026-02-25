// Season.java
package com.f1.domain;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "seasons")
@Getter @Setter @NoArgsConstructor
public class Season {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true)
    private Integer year;

    public Season(Integer year) {
        this.year = year;
    }
}