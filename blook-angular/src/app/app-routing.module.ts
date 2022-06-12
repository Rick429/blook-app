import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AuthGuard } from './guards/auth.guard';
import { LoginGuard } from './guards/login.guard';
import { UnsaveGuard } from './guards/unsave.guard';
import { BookDetailComponent } from './pages/book-detail/book-detail.component';
import { BookTableComponent } from './pages/book-table/book-table.component';
import { ChapterTableComponent } from './pages/chapter-table/chapter-table.component';
import { CommentTableComponent } from './pages/comment-table/comment-table.component';
import { GenreTableComponent } from './pages/genre-table/genre-table.component';
import { LoginComponent } from './pages/login/login.component';
import { PerfilComponent } from './pages/perfil/perfil.component';
import { RegisterComponent } from './pages/register/register.component';
import { ReportTableComponent } from './pages/report-table/report-table.component';
import { UserTableComponent } from './pages/user-table/user-table.component';


const routes: Routes = [
  {path:'books', component:BookTableComponent, pathMatch: 'full', canActivate:[LoginGuard]},
  {path:'genres', component:GenreTableComponent, pathMatch: 'full', canActivate:[AuthGuard]},
  {path:'users', component:UserTableComponent, pathMatch: 'full', canActivate:[AuthGuard]},
  {path:'chapters', component:ChapterTableComponent, pathMatch: 'full', canActivate:[AuthGuard]},
  {path:'comments', component:CommentTableComponent, pathMatch: 'full', canActivate:[AuthGuard]},
  {path:'reports', component:ReportTableComponent, pathMatch: 'full', canActivate:[AuthGuard]},
  {path:'login', component:LoginComponent, pathMatch: 'full'},
  {path:'register', component:RegisterComponent, pathMatch: 'full'},
  {path:'perfil', component:PerfilComponent, pathMatch: 'full', canActivate:[AuthGuard], canDeactivate:[UnsaveGuard]},
  {path:'book/detail/:idbook', component: BookDetailComponent, pathMatch: 'full', canActivate:[AuthGuard]},

  {path:'', pathMatch: 'full', redirectTo:'login'}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
