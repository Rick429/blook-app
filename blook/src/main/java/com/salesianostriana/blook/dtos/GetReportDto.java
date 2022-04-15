package com.salesianostriana.blook.dtos;

import com.salesianostriana.blook.enums.TypeReport;
import lombok.*;
import org.springframework.data.annotation.CreatedDate;

import java.time.LocalDate;
import java.util.UUID;

@AllArgsConstructor
@NoArgsConstructor
@Getter @Setter
@Builder
public class GetReportDto {

    private UUID id;
    private UUID user_id;
    private UUID book_comment_id;
    private String report_comment;
    private TypeReport type_report;
    private LocalDate created_date;

}
