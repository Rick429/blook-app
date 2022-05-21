import { Component, OnInit, ViewChild } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { MatPaginator, PageEvent } from '@angular/material/paginator';
import { MatTableDataSource } from '@angular/material/table';
import { Comment } from 'src/app/models/interfaces/comment_response';
import { CommentService } from 'src/app/services/comment.service';
import { CommentFormComponent } from '../comment-form/comment-form.component';
import { DeleteFormComponent } from '../delete-form/delete-form.component';

@Component({
  selector: 'app-comment-table',
  templateUrl: './comment-table.component.html',
  styleUrls: ['./comment-table.component.css']
})
export class CommentTableComponent implements OnInit {
  displayedColumns: string[] = ['user_id', 'book_id', 'comment', 'nick', 'avatar', 'created_date','acciones'];
  totalElements: number = 0;
  page!:String;
  size!:String;
  dataSource:any;

  @ViewChild(MatPaginator, { static: true }) paginator!: MatPaginator;
  constructor(private dialog:MatDialog, private commentService: CommentService) { }
  ngOnInit(): void {
    this.commentService.findAllComments("0","5").subscribe(commentResult => {
      this.totalElements = commentResult.totalElements;
      this.dataSource = new MatTableDataSource<Comment>(commentResult.content);
      this.dataSource.paginator = this.paginator;
    });
  }

  eliminarComentario(comment:Comment){
    this.dialog.open(DeleteFormComponent, {
     data: {idComment: comment.book_id},
   });
 }



 nextPage(event: PageEvent) {
  this.page = event.pageIndex.toString();
  this.size = event.pageSize.toString();
  this.commentService.findAllComments(this.page, this.size).subscribe(commentResult => {
    this.totalElements = commentResult.totalElements;
    this.dataSource = new MatTableDataSource<Comment>(commentResult.content);
  });
 }

}
