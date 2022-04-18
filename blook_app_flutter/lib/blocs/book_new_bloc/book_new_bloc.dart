import 'package:bloc/bloc.dart';
import 'package:blook_app_flutter/models/book_dto.dart';
import 'package:blook_app_flutter/models/create_book_dto.dart';
import 'package:blook_app_flutter/repository/book_repository/book_repository.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'book_new_event.dart';
part 'book_new_state.dart';

class BookNewBloc extends Bloc<BookNewEvent, BookNewState> {
  final BookRepository bookRepository;
  
  BookNewBloc(this.bookRepository) : super(BookNewInitial()) {
    on<CreateBookEvent>(_onSelectImage);
  }

  void _onSelectImage(CreateBookEvent event, Emitter<BookNewState> emit) async {
    try {
      final book = await bookRepository.createBook(
          event.createBookDto, event.source.toString());

      emit(CreateBookSuccessState(event.source, book));
    } catch (e) {
      emit(const CreateBookErrorState('Error in image selection'));
    }
  }
}
