import { Component, Inject, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { MatDialog, MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { Book } from 'src/app/models/interfaces/book_response';
import { BookService } from 'src/app/services/book.service';
import {saveAs} from 'file-saver';
import { HttpClient } from '@angular/common/http';
import { Genre } from 'src/app/models/interfaces/genre_response';
import { GenreService } from 'src/app/services/genre.service';
import { CreateBookDto } from 'src/app/models/dto/createBookDto';
import { DeleteFormComponent } from '../delete-form/delete-form.component';

const TOKEN = 'token';

export interface BookDialogData {
  book: Book;
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
    genres: new FormControl(['']),
  });
  genresList: Genre[] = [];
  genreSelect:Genre[] = [];
  file!: File;
  createBookDto = new CreateBookDto;
  constructor(public dialogRef: MatDialogRef<BookFormComponent>,
    @Inject(MAT_DIALOG_DATA) public data: BookDialogData,
    private bookService: BookService, private genreService: GenreService,
    private dialog:MatDialog) {
     }

  ngOnInit(): void {
    this.genreService.findAllGenres("0","100").subscribe(res => {
      this.genresList = res.content;
      if(this.data!=null) {
        this.genreSelect = this.genresList.filter(g =>
          this.data.book.genres.some(g2 =>
            g2.id == g.id
          )
        )
      }
    });

    this.formulario.get('genres')?.setValue(this.genreSelect);
    this.formulario.patchValue(this.data.book);
  }

  onFileChanged(event: any) {
    this.file = event.target.files[0];
  }

  cancelar() {
    this.dialogRef.close();
  }

  editarCrear(){
    for (let index = 0; index < this.genreSelect.length; index++) {
      console.log(this.genreSelect[index].name);

    }
    this.createBookDto.name= this.formulario.get('name')?.value;
    this.createBookDto.description= this.formulario.get('description')?.value;
    this.createBookDto.generos= this.genreSelect;
    if(this.data!=null){
      const formData = new FormData();
      formData.append('book', new Blob([JSON.stringify(this.createBookDto)], {
        type: 'application/json'
      }));

      this.bookService.update(formData, this.formulario.get('id')?.value).subscribe(res => {
      });
      if(this.file!=undefined){
        this.bookService.updateCover(this.file, this.data.book.id).subscribe(res => {
        });
      }
      history.go(0);
    } else {
      this.bookService.create(this.createBookDto, this.file).subscribe(m => {
        history.go(0);
      });
    }
    }

  eliminar() {
    this.dialog.open(DeleteFormComponent, {
      data: {idBook: this.data.book.id},
    });
  }


}

