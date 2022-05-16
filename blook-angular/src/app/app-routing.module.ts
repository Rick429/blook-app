import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { BookTableComponent } from './pages/book-table/book-table.component';
import { ChapterTableComponent } from './pages/chapter-table/chapter-table.component';
import { CommentTableComponent } from './pages/comment-table/comment-table.component';
import { GenreTableComponent } from './pages/genre-table/genre-table.component';
import { LoginComponent } from './pages/login/login.component';
import { RegisterComponent } from './pages/register/register.component';
import { ReportTableComponent } from './pages/report-table/report-table.component';
import { UserTableComponent } from './pages/user-table/user-table.component';


const routes: Routes = [
  {path:'login', component:LoginComponent},
  {path:'register', component:RegisterComponent},
  {path:'books', component:BookTableComponent},
  {path:'genres', component:GenreTableComponent},
  {path:'users', component:UserTableComponent},
  {path:'chapters', component:ChapterTableComponent},
  {path:'comments', component:CommentTableComponent},
  {path:'reports', component:ReportTableComponent},
  {path:'', pathMatch: 'full', redirectTo:'login'}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
