part of 'edit_chapter_bloc.dart';

abstract class EditChapterEvent extends Equatable {
  const EditChapterEvent();

  @override
  List<Object> get props => [];
}

class  EditOneChapterEvent extends EditChapterEvent {
  final String source;
  final CreateChapterDto editChapterDto;
  final String id;

  const EditOneChapterEvent(this.source, this.editChapterDto, this.id);

  @override
  List<Object> get props => [source, editChapterDto];
}