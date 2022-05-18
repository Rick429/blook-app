import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Chapter } from '../models/interfaces/book_response';
import { ChapterResponse } from '../models/interfaces/chapter_response';

const TOKEN = 'token';

@Injectable({
  providedIn: 'root'
})
export class ChapterService {

  constructor(private http:HttpClient) { }

  chapterBaseUrl = '/blook/chapter';

  findAllChapters():Observable<ChapterResponse>{
    let encabezados= new HttpHeaders({
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${localStorage.getItem(TOKEN)}`
    })
    return this.http.get<ChapterResponse>(`${this.chapterBaseUrl}/all?size=400`, { headers: encabezados });
  }

  create(chapter: Chapter, idBook:String, file:File){
    let encabezados= new HttpHeaders({
      'Authorization': `Bearer ${localStorage.getItem(TOKEN)}`
    });
    let formData = new FormData();
    formData.append('chapter', new Blob([JSON.stringify(chapter)], {
      type: 'application/json'
    }));
    formData.append("file", file);
    return this.http.post<Chapter>(`${this.chapterBaseUrl}/${idBook}`, formData, { headers: encabezados });
  }

  findById(idChapter: number){
    return this.http.get<Chapter>(`${this.chapterBaseUrl}/${idChapter}`);
  }

  update(chapter: Chapter, idChapter: String){
    return this.http.put<Chapter>(`${this.chapterBaseUrl}/${idChapter}`, chapter);
  }

  delete(idChapter: number){
    return this.http.delete(`${this.chapterBaseUrl}/${idChapter}`);
  }
}
