import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { CommentResponse } from '../models/interfaces/comment_response';

const TOKEN = 'token';

@Injectable({
  providedIn: 'root'
})
export class CommentService {

  constructor(private http:HttpClient) { }

  commentBaseUrl =  `${environment.API_BASE_URL}blook/comment`;

  findAllComments(page:String, size:String):Observable<CommentResponse>{
    let encabezados= new HttpHeaders({
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${localStorage.getItem(TOKEN)}`
    })
    return this.http.get<CommentResponse>(`${this.commentBaseUrl}/all?size=${size}&page=${page}`, { headers: encabezados });
  }

  delete(idComment: String){
    let encabezados= new HttpHeaders({
      'Authorization': `Bearer ${localStorage.getItem(TOKEN)}`
    });
    return this.http.delete(`${this.commentBaseUrl}/${idComment}`, { headers: encabezados });
  }

  buscar(comment: String){
    let encabezados= new HttpHeaders({
      'Authorization': `Bearer ${localStorage.getItem(TOKEN)}`
    });
    let formData = new FormData();
    formData.append('search', new Blob([JSON.stringify(comment)], {
      type: 'application/json'
    }));
    return this.http.post<CommentResponse>(`${this.commentBaseUrl}/search/`, formData, { headers: encabezados });
  }
}
