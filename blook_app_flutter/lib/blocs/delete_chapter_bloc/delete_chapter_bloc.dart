import 'package:bloc/bloc.dart';
import 'package:blook_app_flutter/repository/chapter_repository/chapter_repository.dart';
import 'package:equatable/equatable.dart';

part 'delete_chapter_event.dart';
part 'delete_chapter_state.dart';

class DeleteChapterBloc extends Bloc<DeleteChapterEvent, DeleteChapterState> {
  final ChapterRepository chapterRepository;

  DeleteChapterBloc(this.chapterRepository) : super(DeleteChapterInitial()) {
    on<DeleteOneChapterEvent>(_deleteChapterEvent);
  }

  void _deleteChapterEvent(DeleteOneChapterEvent event, Emitter<DeleteChapterState> emit) {
    try {
        chapterRepository.deleteChapter(event.id);
      emit(DeleteChapterSuccessState());
    } on Exception catch (e) {
      emit(DeleteChapterErrorState(e.toString()));
    }
  }
}
