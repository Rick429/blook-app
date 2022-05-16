import { Component, Inject, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { Book } from 'src/app/models/interfaces/book_response';
import { BookService } from 'src/app/services/book.service';
import {saveAs} from 'file-saver';
import { HttpClient } from '@angular/common/http';
import { Genre } from 'src/app/models/interfaces/genre_response';
import { GenreService } from 'src/app/services/genre.service';

const TOKEN = 'token';

export interface BookDialogData {
  book: Book;
  titulo:String;
}

@Component({
  selector: 'app-book-form',
  templateUrl: './book-form.component.html',
  styleUrls: ['./book-form.component.css']
})
export class BookFormComponent implements OnInit {
  formulario = new FormGroup({
    id: new FormControl(''),
    name: new FormControl(''),
    description: new FormControl(''),
    releaseDate: new FormControl(''),
    genres: new FormControl()
  });
  genresList: Genre[] = [];
  titulo = this.data.titulo;
  file!: File;
  constructor(public dialogRef: MatDialogRef<BookFormComponent>,
    @Inject(MAT_DIALOG_DATA) public data: BookDialogData,
    private bookService: BookService, private genreService: GenreService) {
     }

  ngOnInit(): void {
    this.formulario.patchValue(this.data.book);
    this.genreService.findAllGenres().subscribe(res => {
      this.genresList = res.content;
    })
  }

  onFileChanged(event: any) {
    this.file = event.target.files[0];
  }

  cancelar() {
    this.dialogRef.close();
  }

  editarCrear(){

    if(this.formulario.get('id')?.value!=''){
      const formData = new FormData();
      formData.append('book', new Blob([JSON.stringify(this.formulario.value)], {
        type: 'application/json'
      }));

      this.bookService.update(formData, this.formulario.get('id')?.value).subscribe(res => {
      });
      if(this.file!=undefined){
        this.bookService.updateCover(this.file, this.data.book.id).subscribe(res => {
        });
      }
      history.go(0)
    } else {
      this.bookService.create(this.formulario.value).subscribe(m => {
        history.go(0);
      });
    }
    }

  eliminar() {
    this.bookService.delete(this.data.book.id).subscribe(m => {
      history.go(0);
    });
  }


}

