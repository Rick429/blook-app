part of 'chapter_new_bloc.dart';

abstract class ChapterNewState extends Equatable {
  const ChapterNewState();
  
  @override
  List<Object> get props => [];
}

class ChapterNewInitial extends ChapterNewState {}

class CreateChapterSuccessState extends ChapterNewState {
  final String pickedFile;
  final Chapter chapter;

  const CreateChapterSuccessState(this.pickedFile, this.chapter);

  @override
  List<Object> get props => [pickedFile, chapter];
}

class CreateChapterErrorState extends ChapterNewState {
  final String message;

  const CreateChapterErrorState(this.message);

  @override
  List<Object> get props => [message];
}