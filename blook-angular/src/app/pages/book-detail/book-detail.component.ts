import { DatePipe } from '@angular/common';
import { Component, OnInit, ViewChild } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { MatPaginator } from '@angular/material/paginator';
import { MatTableDataSource } from '@angular/material/table';
import { ActivatedRoute } from '@angular/router';
import { Book, Chapter } from 'src/app/models/interfaces/book_response';
import { BookService } from 'src/app/services/book.service';
import { ChapterFormComponent } from '../chapter-form/chapter-form.component';
import { GenreFormComponent } from '../genre-form/genre-form.component';

@Component({
  selector: 'app-book-detail',
  templateUrl: './book-detail.component.html',
  styleUrls: ['./book-detail.component.css']
})
export class BookDetailComponent implements OnInit {
  displayedColumns: string[] = ['id', 'name', 'file', 'acciones'];
  bookId!: number;
  book!:Book;
  image!:String;
  chapterList: Chapter[] = [];
  dataSource:any;

  @ViewChild(MatPaginator, { static: true }) paginator!: MatPaginator;
  constructor(private bookService: BookService, private route: ActivatedRoute,
    private dialog:MatDialog, public datepipe: DatePipe) { }

  ngOnInit(): void {
    this.route.params.subscribe(params => {
      this.bookId = params['idbook'];
      this.bookService.findById(this.bookId).subscribe({
        next: (result => {
          this.book = result;
          this.image= result.cover;
          this.chapterList = result.chapters;
          this.dataSource = new MatTableDataSource<Chapter>(this.chapterList);
          this.dataSource.paginator = this.paginator;
        }),
        error: err => console.log(err.error.mensaje),
      });
    });
  }

  crearCapitulo() {
    this.dialog.open(ChapterFormComponent, {
      data: {idBook:this.book.id},
    });
   }

   editarCapitulo(chapter:Chapter){
    this.dialog.open(ChapterFormComponent, {
     data: {chapter: chapter},
   });
 }
}
