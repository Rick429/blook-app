import { Component, OnInit, ViewChild } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { MatDialog } from '@angular/material/dialog';
import { MatPaginator, PageEvent } from '@angular/material/paginator';
import { MatTableDataSource } from '@angular/material/table';
import { SearchGenreDto } from 'src/app/models/dto/searchGenreDto';
import { Genre } from 'src/app/models/interfaces/genre_response';
import { GenreService } from 'src/app/services/genre.service';
import { GenreFormComponent } from '../genre-form/genre-form.component';

@Component({
  selector: 'app-genre-table',
  templateUrl: './genre-table.component.html',
  styleUrls: ['./genre-table.component.css']
})
export class GenreTableComponent implements OnInit {
  displayedColumns: string[] = ['id', 'name', 'description', 'acciones'];
  totalElements: number = 0;
  page!:String;
  size!:String;
  dataSource:any;
  formulario = new FormGroup({
    texto: new FormControl(''),
  });
  searchGenreDto = new SearchGenreDto;
  @ViewChild(MatPaginator, { static: true }) paginator!: MatPaginator;
  constructor(private dialog:MatDialog, private genreService: GenreService) { }
  ngOnInit(): void {
    this.genreService.findAllGenres("0","5").subscribe({
      next: (genreResult => {
        this.totalElements = genreResult.totalElements;
        this.dataSource = new MatTableDataSource<Genre>(genreResult.content);
        this.dataSource.paginator = this.paginator;
      }),
      error: err => console.log(err.error.mensaje),
    });
  }

  editarGenero(genre:Genre){
    this.dialog.open(GenreFormComponent, {
     data: {genre: genre},
   });
  }

  crearGenero() {
    this.dialog.open(GenreFormComponent, {
    });
  }

 nextPage(event: PageEvent) {
  this.page = event.pageIndex.toString();
  this.size = event.pageSize.toString();
  this.genreService.findAllGenres(this.page, this.size).subscribe({
    next: (genreResult => {
      this.totalElements = genreResult.totalElements;
      this.dataSource = new MatTableDataSource<Genre>(genreResult.content);
    }),
    error: err => console.log(err.error.mensaje),
  });
 }

 buscar(){
  this.searchGenreDto.name=this.formulario.get('texto')?.value;
  this.searchGenreDto.description=this.formulario.get('texto')?.value;
  this.genreService.buscar(this.searchGenreDto).subscribe({
    next: (genreResult => {
      this.totalElements = genreResult.totalElements;
      this.dataSource = new MatTableDataSource<Genre>(genreResult.content);
    }),
    error: err => console.log(err.error.mensaje),
  });
  }

}
