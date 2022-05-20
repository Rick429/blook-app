import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { User, UserResponse } from '../models/interfaces/user_response';

const TOKEN = 'token';

@Injectable({
  providedIn: 'root'
})
export class UserService {

  constructor(private http:HttpClient) { }

  userBaseUrl =  `${environment.API_BASE_URL}blook/user`;

  findAllUsers(page:String, size:String):Observable<UserResponse>{
    let encabezados= new HttpHeaders({
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${localStorage.getItem(TOKEN)}`
    })
    return this.http.get<UserResponse>(`${this.userBaseUrl}/all?size=${size}&page=${page}`, { headers: encabezados });
  }

  create(user: User, file:File){
    let encabezados= new HttpHeaders({
      'Authorization': `Bearer ${localStorage.getItem(TOKEN)}`
    });
    let formData = new FormData();
    formData.append('user', new Blob([JSON.stringify(user)], {
      type: 'application/json'
    }));
    formData.append("file", file);
    return this.http.post<User>('/blook/auth/register', formData, { headers: encabezados });
  }

  findById(idUser: number){
    return this.http.get<User>(`${this.userBaseUrl}/${idUser}`);
  }

  update(user: any, idUser: number){
    let encabezados= new HttpHeaders({
      'Authorization': `Bearer ${localStorage.getItem(TOKEN)}`
    });
    return this.http.put<User>(`${this.userBaseUrl}/${idUser}`, user, { headers: encabezados });
  }

  delete(idUser: String){
    let encabezados= new HttpHeaders({
      'Authorization': `Bearer ${localStorage.getItem(TOKEN)}`
    });
    return this.http.delete(`${this.userBaseUrl}/${idUser}`, { headers: encabezados });
  }

  updateAvatar(file: File, idUser: String){
    let encabezados= new HttpHeaders({
      'Authorization': `Bearer ${localStorage.getItem(TOKEN)}`
    });

    let formData = new FormData();
    formData.append("file", file);
    return this.http.put<User>(`${this.userBaseUrl}/avatar/`, formData, { headers: encabezados });
  }
}
