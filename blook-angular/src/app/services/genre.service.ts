import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment.prod';
import { SearchGenreDto } from '../models/dto/searchGenreDto';
import { Genre, GenreResponse } from '../models/interfaces/genre_response';

const TOKEN = 'token';

@Injectable({
  providedIn: 'root'
})
export class GenreService {

  constructor(private http:HttpClient) { }

  genreBaseUrl =  `${environment.API_BASE_URL}blook/genre`;

  findAllGenres(page:String, size:String):Observable<GenreResponse>{
    let encabezados= new HttpHeaders({
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${localStorage.getItem(TOKEN)}`
    });
    return this.http.get<GenreResponse>(`${this.genreBaseUrl}/all?size=${size}&page=${page}`, { headers: encabezados });
  }

  create(genre: Genre){
    let encabezados= new HttpHeaders({
    /*   'Content-Type': 'application/json', */
      /* 'Accept':'application/json', */
      'Authorization': `Bearer ${localStorage.getItem(TOKEN)}`
    });
    let genero = new FormData();
    genero.append('genre', new Blob([JSON.stringify(genre)], {
      type: 'application/json'
    }));
    return this.http.post<Genre>(`${this.genreBaseUrl}/`, genero, { headers: encabezados });
  }

  findById(idGenre: number){

    return this.http.get<Genre>(`${this.genreBaseUrl}/${idGenre}`);
  }

  update(genre: Genre, idGenre: String){
    let encabezados= new HttpHeaders({
      'Authorization': `Bearer ${localStorage.getItem(TOKEN)}`
    });
    let genero = new FormData();
    genero.append('genre', new Blob([JSON.stringify(genre)], {
      type: 'application/json'
    }));
    return this.http.put<Genre>(`${this.genreBaseUrl}/${idGenre}`, genero, { headers: encabezados });
  }

  delete(idGenre: String){
    let encabezados= new HttpHeaders({
      'Authorization': `Bearer ${localStorage.getItem(TOKEN)}`
    });
    return this.http.delete(`${this.genreBaseUrl}/${idGenre}`, { headers: encabezados });
  }

  buscar(searchGenreDto: SearchGenreDto){
    let encabezados= new HttpHeaders({
      'Authorization': `Bearer ${localStorage.getItem(TOKEN)}`
    });
    let formData = new FormData();
    formData.append('search', new Blob([JSON.stringify(searchGenreDto)], {
      type: 'application/json'
    }));
    return this.http.post<GenreResponse>(`${this.genreBaseUrl}/find/`, formData, { headers: encabezados });
  }
}
