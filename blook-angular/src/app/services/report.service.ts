import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { ReportReponse } from '../models/interfaces/report_response';

const TOKEN = 'token';

@Injectable({
  providedIn: 'root'
})
export class ReportService {

  constructor(private http:HttpClient) { }

  reportBaseUrl =  `${environment.API_BASE_URL}blook/report`;

  findAllReports():Observable<ReportReponse>{
    let encabezados= new HttpHeaders({
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${localStorage.getItem(TOKEN)}`
    })
    return this.http.get<ReportReponse>(`${this.reportBaseUrl}/all?size=400`, { headers: encabezados });
  }
}
