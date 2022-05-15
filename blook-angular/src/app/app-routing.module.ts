import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { BookFormComponent } from './pages/book-form/book-form.component';
import { BookTableComponent } from './pages/book-table/book-table.component';
import { GenreTableComponent } from './pages/genre-table/genre-table.component';
import { LoginComponent } from './pages/login/login.component';
import { RegisterComponent } from './pages/register/register.component';


const routes: Routes = [
  {path:'login', component:LoginComponent},
  {path:'register', component:RegisterComponent},
  {path:'books', component:BookTableComponent},
  {path:'form', component:BookFormComponent},
  {path:'genres', component:GenreTableComponent},
  {path:'', pathMatch: 'full', redirectTo:'login'}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
