import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { LoginDto } from '../models/dto/loginDto';
import { UserNewDto } from '../models/dto/userNewDto';
import { LoginResponse } from '../models/interfaces/loginResponse';

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

  authBaseUrl = '/blook/auth';

  constructor(private http:HttpClient, private router: Router) { }

  login(loginDto: LoginDto): Observable<LoginResponse> {
    let requestUrl = `${this.authBaseUrl}/login`;
    return this.http.post<LoginResponse>(requestUrl, loginDto, DEFAULT_HEADERS);
  }

  register(userNewDto: UserNewDto): Observable<LoginResponse> {
    let requestUrl = `${this.authBaseUrl}/register`;
    return this.http.post<LoginResponse>(requestUrl, userNewDto, DEFAULT_HEADERS);
  }

  logout(){
    localStorage.clear();
    this.router.navigate(['login'])
  }
}
