import { Component, Inject, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { CreateChapterDto } from 'src/app/models/dto/createChapterDto';
import { Chapter } from 'src/app/models/interfaces/book_response';
import { ChapterService } from 'src/app/services/chapter.service';

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
    private chapterService:ChapterService) { }

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

      this.chapterService.update(formData, this.data.chapter.id).subscribe(res => {
      });
      if(this.file!=undefined){
        this.chapterService.updateFile(this.file, this.data.chapter.id).subscribe(res => {
        });
      }
        history.go(0)
    } else {

      this.chapterService.create(this.formulario.value, this.data.idBook, this.file).subscribe(m => {
        history.go(0);
      });

    }
  }

  eliminar() {
    this.chapterService.delete(this.data.chapter.id).subscribe(m => {
      history.go(0);
    });
  }
}
