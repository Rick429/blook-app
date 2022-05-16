import { DatePipe } from '@angular/common';
import { Component, OnInit, ViewChild } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { MatPaginator } from '@angular/material/paginator';
import { MatTableDataSource } from '@angular/material/table';
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
  bookList: Book[] = [];
  dataSource:any;

  @ViewChild(MatPaginator, { static: true }) paginator!: MatPaginator;
  constructor(private dialog:MatDialog, private bookService: BookService, public datepipe: DatePipe) { }
  ngOnInit(): void {
    this.bookService.findAllBooks().subscribe(bookResult => {
      this.bookList = bookResult.content;
      this.dataSource = new MatTableDataSource<Book>(this.bookList);
      this.dataSource.paginator = this.paginator;
    });
  }

  editarLibro(book:Book){
    this.dialog.open(BookFormComponent, {

     data: {book: book,
      titulo: "Editar Libro"},

   });
 }

 crearLibro() {
  this.dialog.open(BookFormComponent, {
    data: {
      titulo: "Crear Libro"},

  });
 }

}
