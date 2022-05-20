import { Component, OnInit, ViewChild } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { MatPaginator, PageEvent } from '@angular/material/paginator';
import { MatTableDataSource } from '@angular/material/table';
import { User } from 'src/app/models/interfaces/user_response';
import { UserService } from 'src/app/services/user.service';
import { UserFormComponent } from '../user-form/user-form.component';

@Component({
  selector: 'app-user-table',
  templateUrl: './user-table.component.html',
  styleUrls: ['./user-table.component.css']
})
export class UserTableComponent implements OnInit {
  displayedColumns: string[] = ['id','nick', 'name', 'lastname', 'email', 'avatar', 'role', 'acciones'];
  totalElements: number = 0;
  page!:String;
  size!:String;
  dataSource:any;

  @ViewChild(MatPaginator, { static: true }) paginator!: MatPaginator;
  constructor(private dialog:MatDialog, private userService: UserService) { }
  ngOnInit(): void {
    this.userService.findAllUsers("0","5").subscribe(userResult => {
      this.totalElements = userResult.totalElements;
      this.dataSource = new MatTableDataSource<User>(userResult.content);
      this.dataSource.paginator = this.paginator;
    });
  }

  editarUsuario(user:User){
    this.dialog.open(UserFormComponent, {
     data: {user: user,
      titulo: "Editar Usuario"},
   });
 }

 nextPage(event: PageEvent) {
  this.page = event.pageIndex.toString();
  this.size = event.pageSize.toString();
  this.userService.findAllUsers(this.page, this.size).subscribe(userResult => {
    this.totalElements = userResult.totalElements;
    this.dataSource = new MatTableDataSource<User>(userResult.content);
  });

}

}
