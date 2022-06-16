part of 'delete_chapter_bloc.dart';

abstract class DeleteChapterState extends Equatable {
  const DeleteChapterState();
  
  @override
  List<Object> get props => [];
}

class DeleteChapterInitial extends DeleteChapterState {}

class DeleteChapterSuccessState extends DeleteChapterState {

  const DeleteChapterSuccessState();

  @override
  List<Object> get props => [];
}

class DeleteChapterErrorState extends DeleteChapterState {
  final String message;

  const DeleteChapterErrorState(this.message);

  @override
  List<Object> get props => [message];
}