import { Component, Inject, OnInit } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { User } from 'src/app/models/interfaces/user_response';
import { UserService } from 'src/app/services/user.service';

export interface AdminDialogData {
  user:User,
}

@Component({
  selector: 'app-admin-dialog',
  templateUrl: './admin-dialog.component.html',
  styleUrls: ['./admin-dialog.component.css']
})
export class AdminDialogComponent implements OnInit {

  constructor(public dialogRef: MatDialogRef<AdminDialogComponent>,
    @Inject(MAT_DIALOG_DATA) public data: AdminDialogData,
    private userService: UserService) { }

  ngOnInit(): void {
  }

  give(){
    if(this.data!= null){
      if(this.data.user.role=="USER") {
        this.userService.giveAdmin(this.data.user.id).subscribe(m=> {
          history.go(0)
        });
      }else{
        this.userService.removeAdmin(this.data.user.id).subscribe(m=> {
          history.go(0)
        });
      }
    }
  }

  cancelar() {
    this.dialogRef.close();
  }

}
