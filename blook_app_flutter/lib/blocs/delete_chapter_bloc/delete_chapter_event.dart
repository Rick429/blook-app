part of 'delete_chapter_bloc.dart';

abstract class DeleteChapterEvent extends Equatable {
  const DeleteChapterEvent();

  @override
  List<Object> get props => [];
}

class DeleteOneChapterEvent extends DeleteChapterEvent {
  final String id;

  const DeleteOneChapterEvent(this.id);
}