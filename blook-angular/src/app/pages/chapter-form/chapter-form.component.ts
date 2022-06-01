import { Component, Inject, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { MatDialog, MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { CreateChapterDto } from 'src/app/models/dto/createChapterDto';
import { Chapter } from 'src/app/models/interfaces/book_response';
import { ChapterService } from 'src/app/services/chapter.service';
import Swal from 'sweetalert2';
import { DeleteFormComponent } from '../delete-form/delete-form.component';

export interface ChapterDialogData {
  idBook: String;
  chapter:Chapter;
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
  file!: File;
  createChapterDto = new CreateChapterDto;
  constructor(public dialogRef: MatDialogRef<ChapterFormComponent>,
    @Inject(MAT_DIALOG_DATA) public data: ChapterDialogData,
    private chapterService:ChapterService, private dialog:MatDialog) { }

  ngOnInit(): void {
    this.formulario.patchValue(this.data.chapter);
  }

  onFileChanged(event: any) {
    this.file = event.target.files[0];
  }


  cancelar() {
    this.dialogRef.close();
  }

  editarCrear(){
    if(this.data.chapter!=null){
      console.log(this.formulario.get('id')?.value);
      this.createChapterDto.name= this.formulario.get('name')?.value;
      const formData = new FormData();
      formData.append('chapter', new Blob([JSON.stringify(this.formulario.value)], {
        type: 'application/json'
      }));

      this.chapterService.update(formData, this.data.chapter.id).subscribe({
        next: ( res => {
          history.go(0);
        }),
        error: err => Swal.fire({
          icon: 'error',
          title: 'Oops...',
          text: err.error.mensaje,
        })
      });
      if(this.file!=undefined){
        this.chapterService.updateFile(this.file, this.data.chapter.id).subscribe({
          next: ( res => {
            history.go(0);
          }),
          error: err => Swal.fire({
            icon: 'error',
            title: 'Oops...',
            text: err.error.mensaje,
          })
        });
      }else {
        history.go(0);
      }

    } else {

      this.chapterService.create(this.formulario.value, this.data.idBook, this.file).subscribe({
        next: ( res => {
          history.go(0);
        }),
        error: err => Swal.fire({
          icon: 'error',
          title: 'Oops...',
          text: err.error.mensaje,
        })
      });
    }
  }

  eliminar() {
    this.dialog.open(DeleteFormComponent, {
      data: {idChapter: this.data.chapter.id},
    });
  }
}
