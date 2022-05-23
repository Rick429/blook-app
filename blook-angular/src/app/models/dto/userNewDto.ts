export class UserNewDto {
  nick: string;
  name: string;
  lastname: string;
  email:    string;
  password: string;
  password2: string;

  constructor() {
    this.nick = '';
    this.name = '';
    this.lastname = '';
    this.email = '';
    this.password = '';
    this.password2 = '';
  }

}
