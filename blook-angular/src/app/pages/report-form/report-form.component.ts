import { Component, Inject, OnInit } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { Report } from 'src/app/models/interfaces/report_response';
import { ReportService } from 'src/app/services/report.service';
import Swal from 'sweetalert2';

export interface ReportDialogData {
  report:Report,
}

@Component({
  selector: 'app-report-form',
  templateUrl: './report-form.component.html',
  styleUrls: ['./report-form.component.css']
})
export class ReportFormComponent implements OnInit {

  constructor(public dialogRef: MatDialogRef<ReportFormComponent>,
    @Inject(MAT_DIALOG_DATA) public data: ReportDialogData,
    private reportService: ReportService) { }

  ngOnInit(): void {
  }

  finalizar(){
    if(this.data!= null){
      if(this.data.report.estado=="ABIERTO") {
        this.reportService.finalizarReporte(this.data.report.id).subscribe({
          next: ( res => {
            history.go(0);
          }),
          error: err => Swal.fire({
            icon: 'error',
            title: 'Oops...',
            text: err.error.mensaje,
          })
        });
      }else{
        this.reportService.abrirReporte(this.data.report.id).subscribe({
          next: ( res => {
            history.go(0);
          }),
          error: err => Swal.fire({
            icon: 'error',
            title: 'Oops...',
            text: err.error.mensaje,
          })
        });
      }
    }
  }

  cancelar() {
    this.dialogRef.close();
  }

}
