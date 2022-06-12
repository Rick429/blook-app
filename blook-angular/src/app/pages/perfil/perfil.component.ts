
import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { User } from 'src/app/models/interfaces/user_response';
import { AuthService } from 'src/app/services/auth.service';
import { UserService } from 'src/app/services/user.service';
import Swal from 'sweetalert2';


const AVATAR = 'avatar'

@Component({
  selector: 'app-perfil',
  templateUrl: './perfil.component.html',
  styleUrls: ['./perfil.component.css']
})

export class PerfilComponent implements OnInit {
  editar=true;
  formulario = new FormGroup({
    nick: new FormControl(''),
    name: new FormControl(''),
    lastname:new FormControl(''),
    email:new FormControl('')
  });
  formularioPassword = new FormGroup({
    password: new FormControl(''),
    passwordNew:new FormControl(''),
    passwordNew2:new FormControl('')
  });
  file!: File;
  avatar = localStorage.getItem('avatar');
  user!:User;
  constructor(private authService: AuthService, private userService: UserService) { }

  ngOnInit(): void {
    localStorage.setItem('seleccionado', 'Perfil');
    this.authService.userLogged().subscribe({
      next: (m => {
        this.formulario.patchValue(m);
        this.avatar=m.avatar;
        this.user=m;
      }),
      error: err => console.log(err.error.mensaje),
    });

  }

  onFileChanged(event: any) {
    this.file = event.target.files[0];
  }

  guardar(){
    if(this.formularioPassword.get('password')?.value!=''){
      this.userService.editarUsuario(this.formulario.value, this.file, this.user.id,this.formularioPassword.value);
    }else{
      this.userService.editarUsuario(this.formulario.value, this.file, this.user.id);
    }
  }

  editarPerfil(){
    if(this.editar){
      this.editar=false;
    }else{
      this.editar=true;
    }
  }
}
