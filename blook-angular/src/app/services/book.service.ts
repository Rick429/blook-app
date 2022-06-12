import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import * as saveAs from 'file-saver';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { CreateBookDto } from '../models/dto/createBookDto';
import { Book, BookResponse } from '../models/interfaces/book_response';
import { catchError, map, switchMap, } from 'rxjs/operators';
import Swal from 'sweetalert2';

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

  buscar(name: String){
    let encabezados= new HttpHeaders({
      'Authorization': `Bearer ${localStorage.getItem(TOKEN)}`
    });
    let formData = new FormData();
    formData.append('search', new Blob([JSON.stringify(name)], {
      type: 'application/json'
    }));
    return this.http.post<BookResponse>(`${this.bookBaseUrl}/search/all`, formData, { headers: encabezados });
  }

  editarLibro(createBookDto: any, idBook: string, file: File) {
    let encabezados= new HttpHeaders({
      'Authorization': `Bearer ${localStorage.getItem(TOKEN)}`
    });

    let formData2 = new FormData();
    formData2.append('book', new Blob([JSON.stringify(createBookDto)], {
      type: 'application/json'
    }));

    let formData = new FormData();
    formData.append("file", file);

    return this.http.put<Book>(`${this.bookBaseUrl}/${idBook}`, formData2, { headers: encabezados }).pipe(
      file!=undefined?
      switchMap(book =>
        this.http.put<Book>(`${this.bookBaseUrl}/cover/${idBook}`, formData, { headers: encabezados }).pipe(
        map(book2 => ({ book, book2})),
      )):map( book2=> ({book2})),catchError(err => Swal.fire({
        icon: 'error',
        title: 'Oops...',
        text: err.error.mensaje,
      }),),
    ).subscribe({
      next: book2 => Swal.fire('Cambios Guardados', '', 'success').then(r=>{
        history.go(0);
      }),
      error: err => Swal.fire({
        icon: 'error',
        title: 'Oops...',
        text: err.error.mensaje,
      })
    ,})
  }

}
