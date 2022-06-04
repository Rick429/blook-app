package com.salesianostriana.blook.dtos;

import com.salesianostriana.blook.enums.Estado;
import com.salesianostriana.blook.enums.TypeReport;
import lombok.*;

import javax.validation.constraints.NotBlank;

@AllArgsConstructor
@NoArgsConstructor
@Getter @Setter
@Builder
public class CreateReportDto {

    @NotBlank(message = "{report.report.blank}")
    private String report_comment;
    private TypeReport type_report;
    private Estado estado;

}
