import { Component, Inject, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { ChapterService } from 'src/app/services/chapter.service';

export interface ChapterDialogData {
  idBook: String;
  titulo:String;
}

@Component({
  selector: 'app-chapter-form',
  templateUrl: './chapter-form.component.html',
  styleUrls: ['./chapter-form.component.css']
})
export class ChapterFormComponent implements OnInit {
  formulario = new FormGroup({
    name: new FormControl('')
  });
  titulo = this.data.titulo;
  file!: File;
  constructor(public dialogRef: MatDialogRef<ChapterFormComponent>,
    @Inject(MAT_DIALOG_DATA) public data: ChapterDialogData,
    private chapterService:ChapterService) { }

  ngOnInit(): void {
  }

  onFileChanged(event: any) {
    this.file = event.target.files[0];
  }


  cancelar() {
    this.dialogRef.close();
  }

  editarCrear(){


      this.chapterService.create(this.formulario.value, this.data.idBook, this.file).subscribe(m => {
        history.go(0);
      });


  }

  eliminar() {
/*     this.chapterService.delete(this.data.idBook).subscribe(m => {
      history.go(0);
    }); */
  }
}
