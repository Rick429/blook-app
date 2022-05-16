import { Component, OnInit, ViewChild } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { MatPaginator } from '@angular/material/paginator';
import { MatTableDataSource } from '@angular/material/table';
import { Chapter } from 'src/app/models/interfaces/book_response';
import { ChapterService } from 'src/app/services/chapter.service';
import { ChapterFormComponent } from '../chapter-form/chapter-form.component';

@Component({
  selector: 'app-chapter-table',
  templateUrl: './chapter-table.component.html',
  styleUrls: ['./chapter-table.component.css']
})
export class ChapterTableComponent implements OnInit {
  displayedColumns: string[] = ['id', 'name', 'file', 'acciones'];
  chapterList: Chapter[] = [];
  dataSource:any;

  @ViewChild(MatPaginator, { static: true }) paginator!: MatPaginator;
  constructor(private dialog:MatDialog, private chapterService: ChapterService) { }
  ngOnInit(): void {
    this.chapterService.findAllChapters().subscribe(chapterResult => {
      this.chapterList = chapterResult.content;
      this.dataSource = new MatTableDataSource<Chapter>(this.chapterList);
      this.dataSource.paginator = this.paginator;
    });
  }

  editarCapitulo(chapter:Chapter){
    this.dialog.open(ChapterFormComponent, {

     data: {chapter: chapter,
      titulo: "Editar Capitulo"},

   });
 }

 crearCapitulo() {
  this.dialog.open(ChapterFormComponent, {
    data: {
      titulo: "Crear capitulo"},

  });
 }

}
