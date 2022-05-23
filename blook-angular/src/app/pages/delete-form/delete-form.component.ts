import { Component, Inject, OnInit } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { BookService } from 'src/app/services/book.service';
import { ChapterService } from 'src/app/services/chapter.service';
import { CommentService } from 'src/app/services/comment.service';
import { GenreService } from 'src/app/services/genre.service';
import { UserService } from 'src/app/services/user.service';

export interface DialogData {
  idComment:String,
  idUser:String,
  idBook:String,
  idChapter:String,
  idGenre:String
}

@Component({
  selector: 'app-delete-form',
  templateUrl: './delete-form.component.html',
  styleUrls: ['./delete-form.component.css']
})
export class DeleteFormComponent implements OnInit {

  constructor(public dialogRef: MatDialogRef<DeleteFormComponent>,
    @Inject(MAT_DIALOG_DATA) public data: DialogData, private commentService: CommentService,
    private userService:UserService, private bookService: BookService,
    private chapterService: ChapterService, private genreService: GenreService) { }

  ngOnInit(): void {
  }

  eliminar(){
    if(this.data.idComment != null){
      this.commentService.delete(this.data.idComment).subscribe(m=> {
        history.go(0)
      });
    }
    if(this.data.idUser != null){
      this.userService.delete(this.data.idUser).subscribe(m => {
        history.go(0);
      });
    }
    if(this.data.idBook != null){
      this.bookService.delete(this.data.idBook).subscribe(m => {
        history.go(0);
      });
    }
    if(this.data.idChapter != null){
      this.chapterService.delete(this.data.idChapter).subscribe(m => {
        history.go(0);
      });
    }
    if(this.data.idGenre != null){
      this.genreService.delete(this.data.idGenre).subscribe(m => {
        history.go(0);
      });
    }
  }

  cancelar() {
    this.dialogRef.close();
  }

}
