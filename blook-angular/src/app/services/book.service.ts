import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import * as saveAs from 'file-saver';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Book, BookResponse } from '../models/interfaces/book_response';

const TOKEN = 'token';

@Injectable({
  providedIn: 'root'
})
export class BookService {

  constructor(private http:HttpClient) { }

  bookBaseUrl = `/blook/book`;

  findAllBooks():Observable<BookResponse>{
    let encabezados= new HttpHeaders({
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${localStorage.getItem(TOKEN)}`
    })
    return this.http.get<BookResponse>(`${this.bookBaseUrl}/all?size=400`, { headers: encabezados });
  }

  create(book: Book){

    return this.http.post<Book>(`${this.bookBaseUrl}/`, book);
  }

  findById(idBook: number){
    return this.http.get<Book>(`${this.bookBaseUrl}/${idBook}`);
  }

  update(book: any, idBook: number){
    let encabezados= new HttpHeaders({
      'Authorization': `Bearer ${localStorage.getItem(TOKEN)}`
    });
    return this.http.put<Book>(`${this.bookBaseUrl}/${idBook}`, book, { headers: encabezados });
  }

  delete(idBook: String){
    let encabezados= new HttpHeaders({
      'Authorization': `Bearer ${localStorage.getItem(TOKEN)}`
    });
    return this.http.delete(`${this.bookBaseUrl}/${idBook}`, { headers: encabezados });
  }

  updateCover(file: File, idBook: String){
    let encabezados= new HttpHeaders({
      'Authorization': `Bearer ${localStorage.getItem(TOKEN)}`
    });

    let formData = new FormData();
    formData.append("file", file);
    return this.http.put<Book>(`${this.bookBaseUrl}/cover/${idBook}`, formData, { headers: encabezados });
  }


}
