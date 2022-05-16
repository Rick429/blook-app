import { Component, OnInit, ViewChild } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { MatPaginator } from '@angular/material/paginator';
import { MatTableDataSource } from '@angular/material/table';
import { Report } from 'src/app/models/interfaces/report_response';
import { ReportService } from 'src/app/services/report.service';
import { ReportFormComponent } from '../report-form/report-form.component';

@Component({
  selector: 'app-report-table',
  templateUrl: './report-table.component.html',
  styleUrls: ['./report-table.component.css']
})
export class ReportTableComponent implements OnInit {
  displayedColumns: string[] = ['id', 'user_id', 'book_comment_id', 'report_comment', 'type_report', 'created_date','acciones'];
  reportList: Report[] = [];
  dataSource:any;

  @ViewChild(MatPaginator, { static: true }) paginator!: MatPaginator;
  constructor(private dialog:MatDialog, private reportService: ReportService) { }
  ngOnInit(): void {
    this.reportService.findAllReports().subscribe(reportResult => {
      this.reportList = reportResult.content;
      this.dataSource = new MatTableDataSource<Report>(this.reportList);
      this.dataSource.paginator = this.paginator;
    });
  }

  editarReporte(report:Report){
    this.dialog.open(ReportFormComponent, {
     data: {report: report,
      titulo: "Editar reporte"},

   });
 }

 crearReporte() {
  this.dialog.open(ReportFormComponent, {
    data: {
      titulo: "Crear reporte"},

  });
 }

}
