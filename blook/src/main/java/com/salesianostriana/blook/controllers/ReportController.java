package com.salesianostriana.blook.controllers;

import com.salesianostriana.blook.dtos.*;
import com.salesianostriana.blook.models.UserEntity;
import com.salesianostriana.blook.services.ReportService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;
import java.util.UUID;

@RestController
@RequiredArgsConstructor
@RequestMapping("/report")
public class ReportController {

    private final ReportService reportService;
    private final ReportDtoConverter reportDtoConverter;

    @PostMapping("/{id}")
    public ResponseEntity<GetReportDto> createReport(@Valid @RequestPart("report") CreateReportDto c,
                                                     @AuthenticationPrincipal UserEntity user,
                                                     @PathVariable UUID id) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(reportDtoConverter.reportToGetReportDto(reportService.save(c,user, id)));
    }

    @GetMapping("/all")
    public List<GetReportDto> findAllReports (@AuthenticationPrincipal UserEntity user) {
        return reportService.findAllReports();
    }
}
