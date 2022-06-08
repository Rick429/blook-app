import { Component, OnInit } from '@angular/core';
import { AuthService } from 'src/app/services/auth.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-toolbar',
  templateUrl: './toolbar.component.html',
  styleUrls: ['./toolbar.component.css']
})
export class ToolbarComponent implements OnInit {

  constructor(private authService: AuthService) { }

  ngOnInit(): void {
  }

  logout() {
    Swal.fire({
      title: 'Cerrar Sesión',
      text: "¿Seguro que quieres salir?",
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#C00218',
      cancelButtonColor: '#8CC63E',
      cancelButtonText:'No',
      confirmButtonText: 'Si'
    }).then((result) => {
      /* Read more about isConfirmed, isDenied below */
      if (result.isConfirmed) {
        this.authService.logout();
      } else if (result.isDenied) {
        result.dismiss;
      }
    })
  }
}
