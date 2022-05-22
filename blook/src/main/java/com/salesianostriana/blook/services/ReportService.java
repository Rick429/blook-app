package com.salesianostriana.blook.services;

import com.salesianostriana.blook.dtos.*;
import com.salesianostriana.blook.enums.Estado;
import com.salesianostriana.blook.enums.TypeReport;
import com.salesianostriana.blook.enums.UserRole;
import com.salesianostriana.blook.errors.exceptions.ForbiddenException;
import com.salesianostriana.blook.errors.exceptions.ListEntityNotFoundException;
import com.salesianostriana.blook.errors.exceptions.OneEntityNotFound;
import com.salesianostriana.blook.models.Book;
import com.salesianostriana.blook.models.Report;
import com.salesianostriana.blook.models.UserEntity;
import com.salesianostriana.blook.repositories.ReportRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ReportService {

    private final ReportRepository reportRepository;
    private final ReportDtoConverter reportDtoConverter;

    public Report save(CreateReportDto c, UserEntity user, UUID id) {

        Report r = reportDtoConverter.createReportDtoToReport(c);
        r.setBook_comment_id(id);
        r.setUser_id(user.getId());
        return reportRepository.save(r);
    }

    public List<GetReportDto> findAllReports () {
        List<Report> lista = reportRepository.findAll();

        if(lista.isEmpty()) {
            throw new ListEntityNotFoundException(Report.class);
        } else {
            return lista.stream()
                    .map(reportDtoConverter::reportToGetReportDto)
                    .collect(Collectors.toList());
        }
    }

    public Page<GetReportDto> findAllReports (Pageable pageable) {
        Page<Report> lista = reportRepository.findAll(pageable);

        if(lista.isEmpty()) {
            throw new ListEntityNotFoundException(Report.class);
        } else {
            return lista.map(reportDtoConverter::reportToGetReportDto);
        }
    }

    public Page<GetReportDto> buscarReporte(UserEntity user, BuscarReporteDto b, Pageable pageable){
        if(user.getRole().equals(UserRole.ADMIN)){
            Page<Report> lista = buscar(Optional.ofNullable(b.getReport_comment()),
                    Optional.ofNullable(b.getType_report()),
                    Optional.ofNullable(b.getEstado()), pageable);
            if(lista.isEmpty()){
                throw new ListEntityNotFoundException(Report.class);
            } else {
                return lista.map(reportDtoConverter::reportToGetReportDto);
            }
        }else{
            throw new ForbiddenException("No tiene permisos para realizar esta acción");
        }
    }

    public Report finalizarReporte (UserEntity user, UUID idReport){
        if(user.getRole().equals(UserRole.ADMIN)){
           Optional<Report> r = reportRepository.findById(idReport);
            if(r.isPresent()){
               r.get().setEstado(Estado.FINALIZADO);
               return reportRepository.save(r.get());
            } else {
                throw new OneEntityNotFound(idReport.toString(), Report.class);
            }
        }else{
            throw new ForbiddenException("No tiene permisos para realizar esta acción");
        }

    }

    public Report abrirReporte (UserEntity user, UUID idReport){
        if(user.getRole().equals(UserRole.ADMIN)){
            Optional<Report> r = reportRepository.findById(idReport);
            if(r.isPresent()){
                r.get().setEstado(Estado.ABIERTO);
                return reportRepository.save(r.get());
            } else {
                throw new OneEntityNotFound(idReport.toString(), Report.class);
            }
        }else{
            throw new ForbiddenException("No tiene permisos para realizar esta acción");
        }

    }

    private Page<Report> buscar(Optional<String> report_comment, Optional<TypeReport> type_report, Optional<Estado> estado, Pageable pageable) {
        Specification<Report> specReportComment = (root, query, criteriaBuilder) -> {
            if (report_comment.isPresent()) {
                return criteriaBuilder.like(criteriaBuilder.lower(root.get("report_comment")), "%" + report_comment.get().toLowerCase() + "%");
            } else {
                return criteriaBuilder.isTrue(criteriaBuilder.literal(true));
            }
        };

        Specification<Report> specTypeReport = (root, query, criteriaBuilder) -> {
            if (type_report.isPresent()) {
                return criteriaBuilder.equal(root.get("type_report"), type_report.get());
            } else {
                return criteriaBuilder.isTrue(criteriaBuilder.literal(true));
            }

        };

        Specification<Report> specEstado = (root, query, criteriaBuilder) -> {
            if (estado.isPresent()) {
                return criteriaBuilder.equal(root.get("estado"), estado.get());
            } else {
                return criteriaBuilder.isTrue(criteriaBuilder.literal(true));
            }

        };
        Specification<Report> todas =
                specReportComment
                        .and(specTypeReport)
                        .and(specEstado);

        return this.reportRepository.findAll(todas, pageable);
    }
}

