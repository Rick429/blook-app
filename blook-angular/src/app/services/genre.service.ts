import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment.prod';
import { Genre, GenreResponse } from '../models/interfaces/genre_response';

const TOKEN = 'token';

@Injectable({
  providedIn: 'root'
})
export class GenreService {

  constructor(private http:HttpClient) { }

  genreBaseUrl = '/blook/genre';

  findAllGenres():Observable<GenreResponse>{
    let encabezados= new HttpHeaders({
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${localStorage.getItem(TOKEN)}`
    })
    return this.http.get<GenreResponse>(`${this.genreBaseUrl}/all?size=400`, { headers: encabezados });
  }

  create(genre: Genre){
    return this.http.post<Genre>(`${this.genreBaseUrl}/`, genre);
  }

  findById(idGenre: number){

    return this.http.get<Genre>(`${this.genreBaseUrl}/${idGenre}`);
  }

  update(genre: Genre, idGenre: number){
    let encabezados= new HttpHeaders({
      'Authorization': `Bearer ${localStorage.getItem(TOKEN)}`
    });
    let genero = new FormData();
    genero.append('genre', new Blob([JSON.stringify(genre)], {
      type: 'application/json'
    }));
    return this.http.put<Genre>(`${this.genreBaseUrl}/${idGenre}`, genero, { headers: encabezados });
  }

  delete(idGenre: number){
    return this.http.delete(`${this.genreBaseUrl}/${idGenre}`);
  }
}
