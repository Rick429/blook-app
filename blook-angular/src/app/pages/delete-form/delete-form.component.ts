import { Component, Inject, OnInit } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { CommentService } from 'src/app/services/comment.service';

export interface DialogData {
  idComment:String,
}

@Component({
  selector: 'app-delete-form',
  templateUrl: './delete-form.component.html',
  styleUrls: ['./delete-form.component.css']
})
export class DeleteFormComponent implements OnInit {

  constructor(public dialogRef: MatDialogRef<DeleteFormComponent>,
    @Inject(MAT_DIALOG_DATA) public data: DialogData, private commentService: CommentService) { }

  ngOnInit(): void {
  }

  eliminar(){
    if(this.data.idComment != null){
      this.commentService.delete(this.data.idComment).subscribe(m=> {
        history.go(0)
      });
    }
  }

  cancelar() {
    this.dialogRef.close();
  }

}
