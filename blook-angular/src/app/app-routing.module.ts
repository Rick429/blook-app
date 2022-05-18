import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { BookDetailComponent } from './pages/book-detail/book-detail.component';
import { BookTableComponent } from './pages/book-table/book-table.component';
import { ChapterTableComponent } from './pages/chapter-table/chapter-table.component';
import { CommentTableComponent } from './pages/comment-table/comment-table.component';
import { GenreTableComponent } from './pages/genre-table/genre-table.component';
import { LoginComponent } from './pages/login/login.component';
import { RegisterComponent } from './pages/register/register.component';
import { ReportTableComponent } from './pages/report-table/report-table.component';
import { UserTableComponent } from './pages/user-table/user-table.component';


const routes: Routes = [
  {path:'books', component:BookTableComponent, pathMatch: 'full'},
  {path:'genres', component:GenreTableComponent, pathMatch: 'full'},
  {path:'users', component:UserTableComponent, pathMatch: 'full'},
  {path:'chapters', component:ChapterTableComponent, pathMatch: 'full'},
  {path:'comments', component:CommentTableComponent, pathMatch: 'full'},
  {path:'reports', component:ReportTableComponent, pathMatch: 'full'},
  {path:'login', component:LoginComponent, pathMatch: 'full'},
  {path:'register', component:RegisterComponent, pathMatch: 'full'},
  {path:'book/detail/:idbook', component: BookDetailComponent, pathMatch: 'full' },
  {path:'', pathMatch: 'full', redirectTo:'login'}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
