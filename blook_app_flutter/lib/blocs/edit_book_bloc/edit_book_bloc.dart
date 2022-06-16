import 'package:bloc/bloc.dart';
import 'package:blook_app_flutter/models/book_response.dart';
import 'package:blook_app_flutter/models/create_book_dto.dart';
import 'package:blook_app_flutter/repository/book_repository/book_repository.dart';
import 'package:blook_app_flutter/utils/preferences.dart';
import 'package:equatable/equatable.dart';
import 'package:get_storage/get_storage.dart';

import '../../models/error_response.dart';

part 'edit_book_event.dart';
part 'edit_book_state.dart';

class EditBookBloc extends Bloc<EditBookEvent, EditBookState> {
  final BookRepository bookRepository;
  final box = GetStorage();
  
  EditBookBloc(this.bookRepository) : super(EditBookInitial()) {
    on<EditOneBookEvent>(_editBook);
  }

  void _editBook(EditOneBookEvent event, Emitter<EditBookState> emit) async {
    try {
      final book = await bookRepository.editBook(
          event.editBookDto, event.id);
      if(event.source.toString().isNotEmpty){
      final book2 = await bookRepository.editCoverBook(event.source.toString(), event.id);
      }
      box.write("coveredit", "");
      emit(EditBookSuccessState(event.source, book));
    }on ErrorResponse catch (e) {
      emit(EditBookErrorState(e));
    }
  }
}
