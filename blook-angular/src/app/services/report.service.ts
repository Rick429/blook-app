import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { SearchReportDto } from '../models/dto/searchReportDto';
import { Report, ReportReponse } from '../models/interfaces/report_response';

const TOKEN = 'token';

@Injectable({
  providedIn: 'root'
})
export class ReportService {

  constructor(private http:HttpClient) { }

  reportBaseUrl =  `${environment.API_BASE_URL}blook/report`;

  findAllReports(page:String, size:String):Observable<ReportReponse>{
    let encabezados= new HttpHeaders({
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${localStorage.getItem(TOKEN)}`
    });
    return this.http.get<ReportReponse>(`${this.reportBaseUrl}/all?size=${size}&page=${page}`, { headers: encabezados });
  }

  finalizarReporte(idReport: String){
    let encabezados= new HttpHeaders({
      'Authorization': `Bearer ${localStorage.getItem(TOKEN)}`
    });
    return this.http.put<Report>(`${this.reportBaseUrl}/close/${idReport}`, null, { headers: encabezados });
  }

  abrirReporte(idReport: String){
    let encabezados= new HttpHeaders({
      'Authorization': `Bearer ${localStorage.getItem(TOKEN)}`
    });
    console.log(localStorage.getItem(TOKEN));
    return this.http.put<Report>(`${this.reportBaseUrl}/open/${idReport}`, null, { headers: encabezados });
  }

  buscar(searchReportDto: SearchReportDto){
    let encabezados= new HttpHeaders({
      'Authorization': `Bearer ${localStorage.getItem(TOKEN)}`
    });
    let formData = new FormData();
    formData.append('search', new Blob([JSON.stringify(searchReportDto)], {
      type: 'application/json'
    }));
    return this.http.post<ReportReponse>(`${this.reportBaseUrl}/find/`, formData, { headers: encabezados });
  }
}
