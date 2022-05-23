import { Genre } from "../interfaces/genre_response";

export class CreateBookDto {
  name: string;
  description: string;
  relase_date: any;
  generos: Genre[] = [];

  constructor() {
      this.name = '';
      this.description = '';
      this.relase_date = null;
      this.relase_date = [];
  }
}
