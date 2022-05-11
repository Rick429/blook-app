import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { LoginDto } from 'src/app/models/dto/loginDto';

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

  constructor(/* private authService: AuthService, */ private router:Router) { }

  ngOnInit(): void {
  }


}
