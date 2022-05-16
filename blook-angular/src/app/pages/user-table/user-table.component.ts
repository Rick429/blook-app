import { Component, OnInit, ViewChild } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { MatPaginator } from '@angular/material/paginator';
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
  userList: User[] = [];
  dataSource:any;

  @ViewChild(MatPaginator, { static: true }) paginator!: MatPaginator;
  constructor(private dialog:MatDialog, private userService: UserService) { }
  ngOnInit(): void {
    this.userService.findAllUsers().subscribe(userResult => {
      this.userList = userResult.content;
      this.dataSource = new MatTableDataSource<User>(this.userList);
      this.dataSource.paginator = this.paginator;
    });
  }

  editarUsuario(user:User){
    this.dialog.open(UserFormComponent, {

     data: {user: user,
      titulo: "Editar Usuario"},

   });
 }

}
