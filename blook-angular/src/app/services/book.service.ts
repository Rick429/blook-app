import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import * as saveAs from 'file-saver';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { CreateBookDto } from '../models/dto/createBookDto';
import { Book, BookResponse } from '../models/interfaces/book_response';

const TOKEN = 'token';

@Injectable({
  providedIn: 'root'
})
export class BookService {

  constructor(private http:HttpClient) { }

  bookBaseUrl = `${environment.API_BASE_URL}blook/book`;

  findAllBooks(page:String, size:String):Observable<BookResponse>{
    let encabezados= new HttpHeaders({
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${localStorage.getItem(TOKEN)}`
    });
    return this.http.get<BookResponse>(`${this.bookBaseUrl}/all?size=${size}&page=${page}`, { headers: encabezados });
  }

  create(book: CreateBookDto, file:File){
    let encabezados= new HttpHeaders({
      'Authorization': `Bearer ${localStorage.getItem(TOKEN)}`
    });
    let formData = new FormData();
    formData.append('book', new Blob([JSON.stringify(book)], {
      type: 'application/json'
    }));
    formData.append("file", file);
    return this.http.post<Book>(`${this.bookBaseUrl}/`, formData, { headers: encabezados });
  }

  findById(idBook: number){
    let encabezados= new HttpHeaders({
      'Authorization': `Bearer ${localStorage.getItem(TOKEN)}`
    });
    return this.http.get<Book>(`${this.bookBaseUrl}/${idBook}`, { headers: encabezados });
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

  getCover(cover: String){
    let encabezados= new HttpHeaders({
      'Authorization': `Bearer ${localStorage.getItem(TOKEN)}`
    });
    return this.http.get(`${cover}`, { headers: encabezados });
  }

}
