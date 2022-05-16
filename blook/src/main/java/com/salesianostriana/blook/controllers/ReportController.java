package com.salesianostriana.blook.controllers;

import com.salesianostriana.blook.dtos.*;
import com.salesianostriana.blook.models.Genre;
import com.salesianostriana.blook.models.Report;
import com.salesianostriana.blook.models.UserEntity;
import com.salesianostriana.blook.services.ReportService;
import com.salesianostriana.blook.utils.PaginationLinksUtils;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.UriComponentsBuilder;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.List;
import java.util.UUID;

@RestController
@RequiredArgsConstructor
@RequestMapping("/blook/report")
public class ReportController {

    private final ReportService reportService;
    private final ReportDtoConverter reportDtoConverter;
    private final PaginationLinksUtils paginationLinksUtils;

    @Operation(summary = "Crear un reporte")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201",
                    description = "Se crea el reporte correctamente",
                    content = {@Content(mediaType = "aplication/json",
                            schema = @Schema(implementation = Report.class))}),
            @ApiResponse(responseCode = "400",
                    description = "Error en los datos",
                    content = @Content),
    })
    @PostMapping("/{id}")
    public ResponseEntity<GetReportDto> createReport(@Valid @RequestPart("report") CreateReportDto c,
                                                     @AuthenticationPrincipal UserEntity user,
                                                     @PathVariable UUID id) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(reportDtoConverter.reportToGetReportDto(reportService.save(c,user, id)));
    }

    @Operation(summary = "Listar todos los reportes")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se devuelve una lista con todos los reportes",
                    content = {@Content(mediaType = "aplication/json",
                            schema = @Schema(implementation = Report.class))}),
            @ApiResponse(responseCode = "404",
                    description = "La lista esta vacia",
                    content = @Content),
    })
    @GetMapping("/all")
    public ResponseEntity<Page<GetReportDto>> findAllReports (@PageableDefault(size = 10, page = 0) Pageable pageable,
                                                              @AuthenticationPrincipal UserEntity user,
                                                              HttpServletRequest request) {
        Page<GetReportDto> lista = reportService.findAllReports(pageable);
        UriComponentsBuilder uriBuilder = UriComponentsBuilder.fromHttpUrl(request.getRequestURL().toString());
        return ResponseEntity.ok().header("link", paginationLinksUtils.createLinkHeader(lista, uriBuilder)).body(lista);
    }
}
