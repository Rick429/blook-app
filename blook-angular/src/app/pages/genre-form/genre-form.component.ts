import { Component, Inject, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { Genre } from 'src/app/models/interfaces/genre_response';
import { GenreService } from 'src/app/services/genre.service';

export interface GenreDialogData {
  genre: Genre;
  titulo:String;
}

@Component({
  selector: 'app-genre-form',
  templateUrl: './genre-form.component.html',
  styleUrls: ['./genre-form.component.css']
})
export class GenreFormComponent implements OnInit {
  formulario = new FormGroup({
    id: new FormControl(''),
    name: new FormControl(''),
    description: new FormControl('')
  });
  titulo = this.data.titulo;

  constructor(public dialogRef: MatDialogRef<GenreFormComponent>,
    @Inject(MAT_DIALOG_DATA) public data: GenreDialogData,
    private genreService: GenreService) {

     }

  ngOnInit(): void {

    this.formulario.patchValue(this.data.genre);
  }

  cancelar() {
    this.dialogRef.close();
  }

  editarCrear(){

    if(this.formulario.get('id')?.value!=''){
      this.genreService.update(this.formulario.value, this.formulario.get('id')?.value).subscribe(res => {
        history.go(0);
      });
    } else {
      this.genreService.create(this.formulario.value).subscribe(m => {
        history.go(0);
      });
    }

  }

  eliminar() {
    this.genreService.delete(this.data.genre.id).subscribe(m => {
      history.go(0);
    });
  }


}

