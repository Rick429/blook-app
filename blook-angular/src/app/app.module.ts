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
import { UserTableComponent } from './pages/user-table/user-table.component';
import { UserFormComponent } from './pages/user-form/user-form.component';
import { ChapterTableComponent } from './pages/chapter-table/chapter-table.component';
import { ChapterFormComponent } from './pages/chapter-form/chapter-form.component';
import { CommentFormComponent } from './pages/comment-form/comment-form.component';
import { CommentTableComponent } from './pages/comment-table/comment-table.component';
import { ReportTableComponent } from './pages/report-table/report-table.component';
import { ReportFormComponent } from './pages/report-form/report-form.component';
import {NoopAnimationsModule} from '@angular/platform-browser/animations';
import { BookDetailComponent } from './pages/book-detail/book-detail.component';
import { MatPaginatorModule } from '@angular/material/paginator';
import { DeleteFormComponent } from './pages/delete-form/delete-form.component';
import { PerfilComponent } from './pages/perfil/perfil.component';
import { AdminDialogComponent } from './dialogs/admin-dialog/admin-dialog.component';
import { FlexLayoutModule } from '@angular/flex-layout';

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
    GenreFormComponent,
    UserTableComponent,
    UserFormComponent,
    ChapterTableComponent,
    ChapterFormComponent,
    CommentFormComponent,
    CommentTableComponent,
    ReportTableComponent,
    ReportFormComponent,
    BookDetailComponent,
    DeleteFormComponent,
    PerfilComponent,
    AdminDialogComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    MaterialImportsModule,
    FormsModule,
    ReactiveFormsModule,
    BrowserAnimationsModule,
    EllipsisModule,
    MatNativeDateModule,
    NoopAnimationsModule,
    MatPaginatorModule,
    FlexLayoutModule
  ],
  providers: [
    DatePipe
    ],
  bootstrap: [AppComponent]
})
export class AppModule { }
