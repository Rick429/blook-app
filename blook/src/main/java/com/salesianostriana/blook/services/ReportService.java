package com.salesianostriana.blook.services;

import com.salesianostriana.blook.dtos.*;
import com.salesianostriana.blook.errors.exceptions.ListEntityNotFoundException;
import com.salesianostriana.blook.models.Book;
import com.salesianostriana.blook.models.Report;
import com.salesianostriana.blook.models.UserEntity;
import com.salesianostriana.blook.repositories.ReportRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
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


}
