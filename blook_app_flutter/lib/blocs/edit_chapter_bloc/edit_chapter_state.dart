part of 'edit_chapter_bloc.dart';

abstract class EditChapterState extends Equatable {
  const EditChapterState();
  
  @override
  List<Object> get props => [];
}

class EditChapterInitial extends EditChapterState {}

class EditChapterSuccessState extends EditChapterState {
  final Chapter chapter;

  const EditChapterSuccessState( this.chapter);

  @override
  List<Object> get props => [chapter];
}

class EditChapterErrorState extends EditChapterState {
  final ErrorResponse error;

  const EditChapterErrorState(this.error);

  @override
  List<Object> get props => [error];
}