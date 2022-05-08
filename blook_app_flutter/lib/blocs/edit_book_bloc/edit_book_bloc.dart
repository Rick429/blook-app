import 'package:bloc/bloc.dart';
import 'package:blook_app_flutter/models/book_response.dart';
import 'package:blook_app_flutter/models/create_book_dto.dart';
import 'package:blook_app_flutter/repository/book_repository/book_repository.dart';
import 'package:blook_app_flutter/utils/preferences.dart';
import 'package:equatable/equatable.dart';

part 'edit_book_event.dart';
part 'edit_book_state.dart';

class EditBookBloc extends Bloc<EditBookEvent, EditBookState> {
  final BookRepository bookRepository;

  EditBookBloc(this.bookRepository) : super(EditBookInitial()) {
    on<EditOneBookEvent>(_editBook);
  }

  void _editBook(EditOneBookEvent event, Emitter<EditBookState> emit) async {
    try {
      final book = await bookRepository.editBook(
          event.editBookDto, event.source.toString(), event.id);
                       PreferenceUtils.setString("name", "");
                PreferenceUtils.setString("description", "");
                PreferenceUtils.setString("coveredit", "");
      emit(EditBookSuccessState(event.source, book));
    } catch (e) {
      emit(const EditBookErrorState('Error al editar el libro'));
    }
  }
}
