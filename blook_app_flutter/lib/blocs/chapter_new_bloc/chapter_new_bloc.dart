import 'package:bloc/bloc.dart';
import 'package:blook_app_flutter/models/book_response.dart';
import 'package:blook_app_flutter/models/chapter_dto.dart';
import 'package:blook_app_flutter/models/create_chapter_dto.dart';
import 'package:blook_app_flutter/repository/chapter_repository/chapter_repository.dart';
import 'package:equatable/equatable.dart';

part 'chapter_new_event.dart';
part 'chapter_new_state.dart';

class ChapterNewBloc extends Bloc<ChapterNewEvent, ChapterNewState> {
  final ChapterRepository chapterRepository;
  
  ChapterNewBloc(this.chapterRepository) : super(ChapterNewInitial()) {
    on<CreateChapterEvent>(_createNewChapter);
  }

  void _createNewChapter(CreateChapterEvent event, Emitter<ChapterNewState> emit) async {
    try {
      final chapter = await chapterRepository.createChapter(
          event.createChapterDto, event.source, event.idbook);

      emit(CreateChapterSuccessState(event.source, chapter));
    } catch (e) {
      emit(const CreateChapterErrorState('Error in image selection'));
    }
  } 
}
