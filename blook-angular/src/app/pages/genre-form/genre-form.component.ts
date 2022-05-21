import { Component, Inject, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { Genre } from 'src/app/models/interfaces/genre_response';
import { GenreService } from 'src/app/services/genre.service';

export interface GenreDialogData {
  genre: Genre;
}

@Component({
  selector: 'app-genre-form',
  templateUrl: './genre-form.component.html',
  styleUrls: ['./genre-form.component.css']
})
export class GenreFormComponent implements OnInit {
  formulario = new FormGroup({
    name: new FormControl(''),
    description: new FormControl('')
  });

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

    if(this.data.genre!=null){
      this.genreService.update(this.formulario.value, this.data.genre.id).subscribe(res => {
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

