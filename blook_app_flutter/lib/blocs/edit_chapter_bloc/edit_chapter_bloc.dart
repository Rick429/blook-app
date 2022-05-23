import 'package:bloc/bloc.dart';
import 'package:blook_app_flutter/models/book_response.dart';
import 'package:blook_app_flutter/models/create_chapter_dto.dart';
import 'package:blook_app_flutter/repository/chapter_repository/chapter_repository.dart';
import 'package:equatable/equatable.dart';

part 'edit_chapter_event.dart';
part 'edit_chapter_state.dart';

class EditChapterBloc extends Bloc<EditChapterEvent, EditChapterState> {
  final ChapterRepository chapterRepository;
  
  EditChapterBloc(this.chapterRepository) : super(EditChapterInitial()) {
    on<EditOneChapterEvent>(_editChapter);
  }

   void _editChapter(EditOneChapterEvent event, Emitter<EditChapterState> emit) async {
    try {
      var chapter;

      chapter = await chapterRepository.editChapter(event.editChapterDto, event.id);

      if(event.source!="..."){
        chapter = await chapterRepository.editChapterFile(event.source, event.id);
      }
      emit(EditChapterSuccessState(chapter));
    } catch (e) {
      emit(const EditChapterErrorState('Error al editar el capitulo'));
    }
  }
}
