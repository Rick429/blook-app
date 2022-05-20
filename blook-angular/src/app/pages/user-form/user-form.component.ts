import { Component, Inject, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { User } from 'src/app/models/interfaces/user_response';
import { UserService } from 'src/app/services/user.service';

export interface UserDialogData {
  user: User;
  titulo:String;
}

@Component({
  selector: 'app-user-form',
  templateUrl: './user-form.component.html',
  styleUrls: ['./user-form.component.css']
})
export class UserFormComponent implements OnInit {
  formulario = new FormGroup({
    id: new FormControl(''),
    name: new FormControl(''),
    lastname: new FormControl(''),
    password: new FormControl(''),
    password2: new FormControl(''),
  });

  titulo = this.data.titulo;
  file!: File;

  constructor(public dialogRef: MatDialogRef<UserFormComponent>,
    @Inject(MAT_DIALOG_DATA) public data: UserDialogData,
    private userService: UserService) {
     }

  ngOnInit(): void {
    this.formulario.patchValue(this.data.user);
  }

  onFileChanged(event: any) {
    this.file = event.target.files[0];
  }

  cancelar() {
    this.dialogRef.close();
  }

  editarCrear(){
      const formData = new FormData();
      formData.append('user', new Blob([JSON.stringify(this.formulario.value)], {
        type: 'application/json'
      }));

      this.userService.update(formData, this.formulario.get('id')?.value).subscribe(res => {
      });
      if(this.file!=undefined){
        this.userService.updateAvatar(this.file, this.data.user.id).subscribe(res => {
        });
      }
      history.go(0)

    }

  eliminar() {
    this.userService.delete(this.data.user.id).subscribe(m => {
      history.go(0);
    });
  }


}
