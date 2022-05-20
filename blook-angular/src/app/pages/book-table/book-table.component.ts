import { DatePipe } from '@angular/common';
import { Component, OnInit, ViewChild } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { MatPaginator, PageEvent } from '@angular/material/paginator';
import { MatTableDataSource } from '@angular/material/table';
import { Router } from '@angular/router';
import { Book } from 'src/app/models/interfaces/book_response';
import { BookService } from 'src/app/services/book.service';
import { BookFormComponent } from '../book-form/book-form.component';


@Component({
  selector: 'app-book-table',
  templateUrl: './book-table.component.html',
  styleUrls: ['./book-table.component.css']
})
export class BookTableComponent implements OnInit {
  displayedColumns: string[] = ['id', 'name', 'description', 'releaseDate', 'cover', 'autor', 'acciones'];
  dataSource:any;
  totalElements: number = 0;
  page!:String;
  size!:String;
  @ViewChild(MatPaginator, { static: true }) paginator!: MatPaginator;
  constructor(private dialog:MatDialog, private bookService: BookService, public datepipe: DatePipe
    ,private router: Router) { }
  ngOnInit(): void {
    this.bookService.findAllBooks("0","5").subscribe(bookResult => {
      this.totalElements = bookResult.totalElements;
      this.dataSource = new MatTableDataSource<Book>(bookResult.content);
      this.dataSource.paginator = this.paginator;
    });
  }

  editarLibro(book:Book){
    this.dialog.open(BookFormComponent, {
     data: {book: book},
   });
 }

 crearLibro() {
  this.dialog.open(BookFormComponent, {
  });
 }

 nextPage(event: PageEvent) {

  this.page = event.pageIndex.toString();
  this.size = event.pageSize.toString();
  this.bookService.findAllBooks(this.page, this.size).subscribe(bookResult => {
    this.totalElements = bookResult.totalElements;
    this.dataSource = new MatTableDataSource<Book>(bookResult.content);
  });

}

}
