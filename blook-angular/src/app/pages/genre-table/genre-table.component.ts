import { Component, OnInit, ViewChild } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { MatPaginator } from '@angular/material/paginator';
import { MatTableDataSource } from '@angular/material/table';
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
  genreList: Genre[] = [];
  dataSource:any;

  @ViewChild(MatPaginator, { static: true }) paginator!: MatPaginator;
  constructor(private dialog:MatDialog, private genreService: GenreService) { }
  ngOnInit(): void {
    this.genreService.findAllGenres().subscribe(genreResult => {
      this.genreList = genreResult.content;
      this.dataSource = new MatTableDataSource<Genre>(this.genreList);
      this.dataSource.paginator = this.paginator;
    });
  }

  editarGenero(genre:Genre){
    this.dialog.open(GenreFormComponent, {

     data: {genre: genre,
      titulo: "Editar Género"},

   });
 }

 crearGenero() {
  this.dialog.open(GenreFormComponent, {
    data: {
      titulo: "Crear Género"},

  });
 }

}
