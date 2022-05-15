import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Chapter } from '../models/interfaces/book_response';

const TOKEN = 'token';

@Injectable({
  providedIn: 'root'
})
export class ChapterService {

  constructor(private http:HttpClient) { }

  chapterBaseUrl = `${environment.API_BASE_URL}chapter`;

 /*  findAllChapters():Observable<>{
    let encabezados= new HttpHeaders({
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${localStorage.getItem(TOKEN)}`
    })
    return this.http.get<BookResponse>(`${this.chapterBaseUrl}/all?size=400`, { headers: encabezados });
  }

  create(chapter: Chapter){
    return this.http.post<Chapter>(`${this.chapterBaseUrl}/`, chapter);
  }

  findById(idChapter: number){
    return this.http.get<Chapter>(`${this.chapterBaseUrl}/${idChapter}`);
  }

  update(chapter: Chapter, idChapter: number){
    return this.http.put<Chapter>(`${this.chapterBaseUrl}/${idChapter}`, chapter);
  }

  delete(idChapter: number){
    return this.http.delete(`${this.chapterBaseUrl}/${idChapter}`);
  } */
}
