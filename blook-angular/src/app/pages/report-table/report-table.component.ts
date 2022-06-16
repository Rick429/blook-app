import { Component, OnInit, ViewChild } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { MatDialog } from '@angular/material/dialog';
import { MatPaginator, PageEvent } from '@angular/material/paginator';
import { MatTableDataSource } from '@angular/material/table';
import { SearchReportDto } from 'src/app/models/dto/searchReportDto';
import { Report } from 'src/app/models/interfaces/report_response';
import { ReportService } from 'src/app/services/report.service';
import { ReportFormComponent } from '../report-form/report-form.component';

@Component({
  selector: 'app-report-table',
  templateUrl: './report-table.component.html',
  styleUrls: ['./report-table.component.css']
})
export class ReportTableComponent implements OnInit {
  displayedColumns: string[] = ['id', 'user_id', 'book_comment_id', 'report_comment', 'type_report', 'created_date', 'estado', 'acciones'];
  totalElements: number = 0;
  page!:String;
  size!:String;
  dataSource:any;
  formulario = new FormGroup({
    texto: new FormControl(''),
    tipo: new FormControl(''),
    estado: new FormControl('')
  });
  searchReportDto = new SearchReportDto;

  @ViewChild(MatPaginator, { static: true }) paginator!: MatPaginator;
  constructor(private dialog:MatDialog, private reportService: ReportService) { }
  ngOnInit(): void {
    this.reportService.findAllReports("0","5").subscribe({
      next: (reportResult => {
        this.totalElements = reportResult.totalElements;
        this.dataSource = new MatTableDataSource<Report>(reportResult.content);
        this.dataSource.paginator = this.paginator;
      }),
      error: err => console.log(err.error.mensaje)
    });
  }

  cerrarAbrir(report:Report){
    this.dialog.open(ReportFormComponent, {
     data: {report: report},
   });
 }


 nextPage(event: PageEvent) {
  this.page = event.pageIndex.toString();
  this.size = event.pageSize.toString();
  this.reportService.findAllReports(this.page, this.size).subscribe({
    next: (reportResult => {
      this.totalElements = reportResult.totalElements;
      this.dataSource = new MatTableDataSource<Report>(reportResult.content);
    }),
    error: err => console.log(err.error.mensaje)
  });
 }

 buscar(){
  this.searchReportDto.report_comment=this.formulario.get('texto')?.value;

  if(this.formulario.get('tipo')?.value!=""){
    this.searchReportDto.type_report=this.formulario.get('tipo')?.value;
  }
  if(this.formulario.get('estado')?.value!=""){
    this.searchReportDto.estado=this.formulario.get('estado')?.value;
  }

  this.reportService.buscar(this.searchReportDto).subscribe({
    next: (reportResult => {
      this.totalElements = reportResult.totalElements;
      this.dataSource = new MatTableDataSource<Report>(reportResult.content);
    }),
    error: err => console.log(err.error.mensaje)
    });
  }
}
