package com.salesianostriana.blook.dtos;

import com.salesianostriana.blook.models.Report;
import org.springframework.stereotype.Component;

@Component
public class ReportDtoConverter {

    public Report createReportDtoToReport(CreateReportDto c) {
        return Report.builder()
                .report_comment(c.getReport_comment())
                .type_report(c.getType_report())
                .estado(c.getEstado())
                .build();
    }

    public GetReportDto reportToGetReportDto(Report r) {
        return GetReportDto.builder()
                .id(r.getId())
                .book_comment_id(r.getBook_comment_id())
                .user_id(r.getUser_id())
                .report_comment(r.getReport_comment())
                .type_report(r.getType_report())
                .created_date(r.getCreated_date())
                .estado(r.getEstado())
                .build();
    }
}
