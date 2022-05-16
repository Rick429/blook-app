import { Component, OnInit, ViewChild } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { MatPaginator } from '@angular/material/paginator';
import { MatTableDataSource } from '@angular/material/table';
import { Comment } from 'src/app/models/interfaces/comment_response';
import { CommentService } from 'src/app/services/comment.service';
import { CommentFormComponent } from '../comment-form/comment-form.component';

@Component({
  selector: 'app-comment-table',
  templateUrl: './comment-table.component.html',
  styleUrls: ['./comment-table.component.css']
})
export class CommentTableComponent implements OnInit {
  displayedColumns: string[] = ['user_id', 'book_id', 'comment', 'nick', 'avatar', 'created_date','acciones'];
  commentList: Comment[] = [];
  dataSource:any;

  @ViewChild(MatPaginator, { static: true }) paginator!: MatPaginator;
  constructor(private dialog:MatDialog, private commentService: CommentService) { }
  ngOnInit(): void {
    this.commentService.findAllComments().subscribe(commentResult => {
      this.commentList = commentResult.content;
      this.dataSource = new MatTableDataSource<Comment>(this.commentList);
      this.dataSource.paginator = this.paginator;
    });
  }

  editarComentario(comment:Comment){
    this.dialog.open(CommentFormComponent, {
     data: {comment: comment,
      titulo: "Editar comentario"},

   });
 }

 crearComentario() {
  this.dialog.open(CommentFormComponent, {
    data: {
      titulo: "Crear comentario"},

  });
 }

}
