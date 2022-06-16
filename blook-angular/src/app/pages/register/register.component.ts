import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { LoginDto } from 'src/app/models/dto/loginDto';
import { AuthService } from 'src/app/services/auth.service';

const TOKEN = 'token'
const AVATAR = 'avatar'
const ROL = 'rol'

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent implements OnInit {
  formulario = new FormGroup({
    nick: new FormControl('', [Validators.required]),
    name: new FormControl(''),
    lastname: new FormControl(''),
    email: new FormControl('', [Validators.required]),
    password: new FormControl('', [Validators.required]),
    password2: new FormControl('', [Validators.required]),
  });
  loginDto = new LoginDto();

  constructor(private authService: AuthService, private router:Router) { }

  ngOnInit(): void {
  }


  registrarse(){
    this.authService.register(this.formulario.value).subscribe(loginResult => {
        localStorage.setItem(TOKEN, loginResult.token);
        localStorage.setItem(ROL, loginResult.role);
        localStorage.setItem(AVATAR, loginResult.avatar);
        this.router.navigate(['/books']);
  });
  }

}
