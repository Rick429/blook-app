export interface BookResponse {
  content:          Book[];
  pageable:         Pageable;
  last:             boolean;
  totalPages:       number;
  totalElements:    number;
  size:             number;
  number:           number;
  sort:             Sort;
  first:            boolean;
  numberOfElements: number;
  empty:            boolean;
}

export interface Book {
  id:          string;
  name:        string;
  description: string;
  releaseDate: string;
  cover:       string;
  autor:       string;
  chapters:    Chapter[];
  comments:    any[];
  genres:      any[];
}

export interface Chapter {
  id:   string;
  name: string;
  file: string;
}

export interface Pageable {
  sort:       Sort;
  offset:     number;
  pageSize:   number;
  pageNumber: number;
  paged:      boolean;
  unpaged:    boolean;
}

export interface Sort {
  empty:    boolean;
  sorted:   boolean;
  unsorted: boolean;
}
