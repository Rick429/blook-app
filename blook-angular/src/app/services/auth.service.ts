import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { LoginDto } from '../models/dto/loginDto';
import { UserNewDto } from '../models/dto/userNewDto';
import { LoginResponse } from '../models/interfaces/loginResponse';
import { User } from '../models/interfaces/user_response';

const TOKEN = 'token';

const DEFAULT_HEADERS = {
  headers: new HttpHeaders({
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  })
};

@Injectable({
  providedIn: 'root'
})
export class AuthService {

  authBaseUrl = `${environment.API_BASE_URL}blook/auth`;

  constructor(private http:HttpClient, private router: Router) { }

  login(loginDto: LoginDto): Observable<LoginResponse> {
    let requestUrl = `${this.authBaseUrl}/login`;
    return this.http.post<LoginResponse>(requestUrl, loginDto, DEFAULT_HEADERS);
  }

  register(userNewDto: UserNewDto): Observable<LoginResponse> {
    let formData = new FormData();
    formData.append('user', new Blob([JSON.stringify(userNewDto)], {
      type: 'application/json'
    }));
    let requestUrl = `${this.authBaseUrl}/register`;
    return this.http.post<LoginResponse>(requestUrl, formData);
  }

  userLogged(): Observable<User> {
    let encabezados= new HttpHeaders({
      'Authorization': `Bearer ${localStorage.getItem(TOKEN)}`
    });
    let requestUrl = `${environment.API_BASE_URL}blook/me`;
    return this.http.get<User>(requestUrl, { headers: encabezados });
  }

  logout(){
    localStorage.clear();
    this.router.navigate(['login'])
  }
}
