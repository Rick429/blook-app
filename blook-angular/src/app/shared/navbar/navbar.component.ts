import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-navbar',
  templateUrl: './navbar.component.html',
  styleUrls: ['./navbar.component.css']
})
export class NavbarComponent implements OnInit {

  open: boolean = true;
  select: string | undefined ;
  currentUrl!: string;
  pantalla1: any ={
    name: "Usuarios",
    icon: "user.svg",
    url:"/users"
  }
  pantalla2: any ={
    name: "Libros",
    icon: "book.svg",
    url:"/books"
  }
  pantalla3: any ={
    name: "Capitulos",
    icon: "file-text.svg",
    url:"/chapters"
  }
  pantalla4: any ={
    name: "Comentarios",
    icon: "comment.svg",
    url:"/comments"
  }
  pantalla5: any ={
    name: "Reportes",
    icon: "warning_amber.svg",
    url:"/reports"
  }
  pantalla6: any ={
    name: "Géneros",
    icon: "list.svg",
    url:"/genres"
  }


  listAux: any[] = [];
  constructor(private router: Router) {
    if(window.location.href.includes("/#/")){
      this.currentUrl = window.location.href.split("/#/")[1];
      this.currentUrl = this.currentUrl.split("/")[0];
      this.select = this.currentUrl;
    }
    this.listAux.push(this.pantalla1);
    this.listAux.push(this.pantalla2);
    this.listAux.push(this.pantalla3);
    this.listAux.push(this.pantalla4);
    this.listAux.push(this.pantalla5);
    this.listAux.push(this.pantalla6);
  }


  ngOnInit(): void {
    this.select =this.select;
  }

  seleccionar(element:any){
    this.select = element.name;
    this.router.navigateByUrl(element.url)

  }

}
