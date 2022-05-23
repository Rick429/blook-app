import { Component, OnInit, ViewChild } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { MatDialog } from '@angular/material/dialog';
import { MatPaginator, PageEvent } from '@angular/material/paginator';
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
  dataSource:any;
  totalElements: number = 0;
  page!:String;
  size!:String;
  formulario = new FormGroup({
    name: new FormControl(''),
  });


  @ViewChild(MatPaginator, { static: true }) paginator!: MatPaginator;
  constructor(private dialog:MatDialog, private chapterService: ChapterService) { }
  ngOnInit(): void {
    this.chapterService.findAllChapters("0","5").subscribe(chapterResult => {
      this.totalElements = chapterResult.totalElements;
      this.dataSource = new MatTableDataSource<Chapter>(chapterResult.content);
      this.dataSource.paginator = this.paginator;
    });
  }

  editarCapitulo(chapter:Chapter){
    this.dialog.open(ChapterFormComponent, {
     data: {chapter: chapter},
   });
 }

 crearCapitulo() {
  this.dialog.open(ChapterFormComponent, {
  });
 }

 nextPage(event: PageEvent) {
  this.page = event.pageIndex.toString();
  this.size = event.pageSize.toString();
  this.chapterService.findAllChapters(this.page, this.size).subscribe(chapterResult => {
    this.totalElements = chapterResult.totalElements;
    this.dataSource = new MatTableDataSource<Chapter>(chapterResult.content);
  });
 }

  buscar(){
  this.chapterService.buscar(this.formulario.value).subscribe(chapterResult => {
    this.totalElements = chapterResult.totalElements;
    this.dataSource = new MatTableDataSource<Chapter>(chapterResult.content);
  });
  }
}
