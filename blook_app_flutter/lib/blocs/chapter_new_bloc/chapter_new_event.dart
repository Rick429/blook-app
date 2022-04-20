part of 'chapter_new_bloc.dart';

abstract class ChapterNewEvent extends Equatable {
  const ChapterNewEvent();

  @override
  List<Object> get props => [];
}

class CreateChapterEvent extends ChapterNewEvent {
  final String source;
  final CreateChapterDto createChapterDto;
  final String idbook;

  const CreateChapterEvent(this.source, this.createChapterDto, this.idbook);

  @override
  List<Object> get props => [source, createChapterDto, idbook];
}
