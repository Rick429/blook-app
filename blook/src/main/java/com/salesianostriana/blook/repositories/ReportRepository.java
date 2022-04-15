package com.salesianostriana.blook.repositories;

import com.salesianostriana.blook.models.Report;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.UUID;

public interface ReportRepository extends JpaRepository<Report, UUID> {
}
