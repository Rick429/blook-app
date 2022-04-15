package com.salesianostriana.blook.dtos;

import com.salesianostriana.blook.enums.TypeReport;
import lombok.*;

@AllArgsConstructor
@NoArgsConstructor
@Getter @Setter
@Builder
public class CreateReportDto {

    private String report_comment;
    private TypeReport type_report;

}
