import { DatePipe } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { ActivatedRoute } from '@angular/router';
import { Book } from 'src/app/models/interfaces/book_response';
import { BookService } from 'src/app/services/book.service';
import { ChapterFormComponent } from '../chapter-form/chapter-form.component';
import { GenreFormComponent } from '../genre-form/genre-form.component';

@Component({
  selector: 'app-book-detail',
  templateUrl: './book-detail.component.html',
  styleUrls: ['./book-detail.component.css']
})
export class BookDetailComponent implements OnInit {
  bookId!: number;
  book!:Book;
  image!:String;
  constructor(private bookService: BookService, private route: ActivatedRoute,
    private dialog:MatDialog, public datepipe: DatePipe) { }

  ngOnInit(): void {
    this.route.params.subscribe(params => {
      this.bookId = params['idbook'];
      this.bookService.findById(this.bookId).subscribe(result => {
        this.book = result;
      });
    });
  }

  crearCapitulo() {
    this.dialog.open(ChapterFormComponent, {
      data: {
        titulo: "Crear Capitulo",
        idBook:this.book.id
      },

    });
   }
}
