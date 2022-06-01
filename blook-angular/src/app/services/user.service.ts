import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { SearchUserDto } from '../models/dto/searchUserDto';
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

  update(user: any, idUser: String){
    let formData = new FormData();
    formData.append('user', new Blob([JSON.stringify(user)], {
      type: 'application/json'
    }));
    let encabezados= new HttpHeaders({
      'Authorization': `Bearer ${localStorage.getItem(TOKEN)}`
    });
    return this.http.put<User>(`${this.userBaseUrl}/${idUser}`, formData, { headers: encabezados });
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
    return this.http.put<User>(`${this.userBaseUrl}/avatar/${idUser}`, formData, { headers: encabezados });
  }

  changePassword(changePassword: any){
    let formData = new FormData();
    formData.append('user', new Blob([JSON.stringify(changePassword)], {
      type: 'application/json'
    }));
    let encabezados= new HttpHeaders({
      'Authorization': `Bearer ${localStorage.getItem(TOKEN)}`
    });
    return this.http.put<User>(`${this.userBaseUrl}/change/`, formData, { headers: encabezados });
  }

  giveAdmin(idUser: String){
    let encabezados= new HttpHeaders({
      'Authorization': `Bearer ${localStorage.getItem(TOKEN)}`
    });
    return this.http.put<User>(`${this.userBaseUrl}/give/admin/${idUser}`, null, { headers: encabezados });
  }

  removeAdmin(idUser: String){
    let encabezados= new HttpHeaders({
      'Authorization': `Bearer ${localStorage.getItem(TOKEN)}`
    });
    console.log(localStorage.getItem(TOKEN));
    return this.http.put<User>(`${this.userBaseUrl}/remove/admin/${idUser}`, null, { headers: encabezados });
  }

  buscar(searchUserDto: SearchUserDto){
    let encabezados= new HttpHeaders({
      'Authorization': `Bearer ${localStorage.getItem(TOKEN)}`
    });
    let formData = new FormData();
    formData.append('search', new Blob([JSON.stringify(searchUserDto)], {
      type: 'application/json'
    }));
    return this.http.post<UserResponse>(`${this.userBaseUrl}/find/`, formData, { headers: encabezados });
  }
}
