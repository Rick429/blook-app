export interface UserResponse {
  content:          User[];
  pageable:         Pageable;
  last:             boolean;
  totalElements:    number;
  totalPages:       number;
  size:             number;
  number:           number;
  sort:             Sort;
  first:            boolean;
  numberOfElements: number;
  empty:            boolean;
}

export interface User {
  id:       string;
  nick:     string;
  name:     string;
  lastname: string;
  email:    string;
  avatar:   string;
  role:     string;
  libros:   Libro[];
}

export interface Libro {
  id:          string;
  name:        string;
  description: string;
  releaseDate: string;
  cover:       string;
  autor:       string;
  chapters:    Chapter[];
  comments:    any[];
  genres:      Genre[];
}

export interface Chapter {
  id:   string;
  name: string;
  file: string;
}

export interface Genre {
  id:          string;
  name:        string;
  description: string;
}

export interface Pageable {
  sort:       Sort;
  offset:     number;
  pageNumber: number;
  pageSize:   number;
  paged:      boolean;
  unpaged:    boolean;
}

export interface Sort {
  empty:    boolean;
  unsorted: boolean;
  sorted:   boolean;
}
