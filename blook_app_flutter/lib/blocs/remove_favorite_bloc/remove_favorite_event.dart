part of 'remove_favorite_bloc.dart';

abstract class RemoveFavoriteEvent extends Equatable {
  const RemoveFavoriteEvent();

  @override
  List<Object> get props => [];
}

class RemoveFavoriteBookEvent extends RemoveFavoriteEvent {
  final String id;

  const RemoveFavoriteBookEvent(this.id);
}