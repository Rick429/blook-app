import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { BrowserModule } from '@angular/platform-browser';
import { AppComponent } from './app.component';
import { MaterialImportsModule } from './modules/material-imports.module';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { LoginComponent } from './pages/login/login.component';
import { AppRoutingModule } from './app-routing.module';
import { RegisterComponent } from './pages/register/register.component';
import { BookTableComponent } from './pages/book-table/book-table.component';
import { ToolbarComponent } from './shared/toolbar/toolbar.component';
import { EllipsisModule } from 'ngx-ellipsis';
import { DatePipe } from '@angular/common';
import { BookFormComponent } from './pages/book-form/book-form.component';
import {MatNativeDateModule} from '@angular/material/core';
import { NavbarComponent } from './shared/navbar/navbar.component';
import { GenreTableComponent } from './pages/genre-table/genre-table.component';
import { GenreFormComponent } from './pages/genre-form/genre-form.component';

@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    RegisterComponent,
    BookTableComponent,
    ToolbarComponent,
    BookFormComponent,
    NavbarComponent,
    GenreTableComponent,
    GenreFormComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    MaterialImportsModule,
    FormsModule,
    ReactiveFormsModule,
    BrowserAnimationsModule,
    EllipsisModule,
    MatNativeDateModule
  ],
  providers: [
    DatePipe
    ],
  bootstrap: [AppComponent]
})
export class AppModule { }
