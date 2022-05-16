import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { CommentResponse } from '../models/interfaces/comment_response';

const TOKEN = 'token';

@Injectable({
  providedIn: 'root'
})
export class CommentService {

  constructor(private http:HttpClient) { }

  commentBaseUrl = '/blook/comment';

  findAllComments():Observable<CommentResponse>{
    let encabezados= new HttpHeaders({
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${localStorage.getItem(TOKEN)}`
    })
    return this.http.get<CommentResponse>(`${this.commentBaseUrl}/all?size=400`, { headers: encabezados });
  }
}
