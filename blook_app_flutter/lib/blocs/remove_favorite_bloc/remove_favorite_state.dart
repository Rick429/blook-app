part of 'remove_favorite_bloc.dart';

abstract class RemoveFavoriteState extends Equatable {
  const RemoveFavoriteState();
  
  @override
  List<Object> get props => [];
}

class RemoveFavoriteInitial extends RemoveFavoriteState {}

class RemoveSuccessState extends RemoveFavoriteState {

  const RemoveSuccessState();

  @override
  List<Object> get props => [];
}

class RemoveErrorState extends RemoveFavoriteState {
  final String message;

  const RemoveErrorState(this.message);

  @override
  List<Object> get props => [message];
}