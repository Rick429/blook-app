package com.salesianostriana.blook.repositories;

import com.salesianostriana.blook.dtos.GetReportDto;
import com.salesianostriana.blook.models.Report;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.UUID;

public interface ReportRepository extends JpaRepository<Report, UUID> {

    Page<Report> findAll(Specification<Report> todas, Pageable pageable);
}
