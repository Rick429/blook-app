export class SearchUserDto {
  nick: string;
  name: string;
  lastname: string;
  email:    string;
  role: any;

  constructor() {
    this.nick = '';
    this.name = '';
    this.lastname = '';
    this.email = '';
    this.role = null;
  }
}
