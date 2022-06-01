import { Component, Inject, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { MatDialog, MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { User } from 'src/app/models/interfaces/user_response';
import { UserService } from 'src/app/services/user.service';
import Swal from 'sweetalert2';
import { DeleteFormComponent } from '../delete-form/delete-form.component';

export interface UserDialogData {
  user: User;
}

@Component({
  selector: 'app-user-form',
  templateUrl: './user-form.component.html',
  styleUrls: ['./user-form.component.css']
})
export class UserFormComponent implements OnInit {
  formulario = new FormGroup({
    nick: new FormControl(''),
    name: new FormControl(''),
    lastname:new FormControl(''),
    email:new FormControl('')
  });
  file!: File;

  constructor(public dialogRef: MatDialogRef<UserFormComponent>,
    @Inject(MAT_DIALOG_DATA) public data: UserDialogData,
    private userService: UserService, private dialog:MatDialog) {
     }

  ngOnInit(): void {
    this.formulario.patchValue(this.data.user);
    console.log(JSON.stringify(this.formulario.value));
  }

  onFileChanged(event: any) {
    this.file = event.target.files[0];
  }

  cancelar() {
    this.dialogRef.close();
  }

  editarCrear(){
      this.userService.update(this.formulario.value, this.data.user.id).subscribe({
        next: ( res => {
        }),
        error: err => Swal.fire({
          icon: 'error',
          title: 'Oops...',
          text: err.error.mensaje,
        })
      });
      if(this.file!=undefined){
        this.userService.updateAvatar(this.file, this.data.user.id).subscribe({
          next: ( res => {
            history.go(0);
          }),
          error: err => Swal.fire({
            icon: 'error',
            title: 'Oops...',
            text: err.error.mensaje,
          })
        });
      } else {
        history.go(0);
      }

    }

  eliminar() {
    this.dialog.open(DeleteFormComponent, {
      data: {idUser: this.data.user.id},
    });
  }


}
