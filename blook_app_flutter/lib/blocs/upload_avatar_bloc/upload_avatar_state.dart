part of 'upload_avatar_bloc.dart';

abstract class UploadAvatarState extends Equatable {
  const UploadAvatarState();
  
  @override
  List<Object> get props => [];
  
}

class UploadAvatarInitial extends UploadAvatarState {}

class UploadAvatarLoadingState extends UploadAvatarState {}

class UploadAvatarSuccessState extends UploadAvatarState {
  final User user;

  const UploadAvatarSuccessState(this.user);

  @override
  List<Object> get props => [user];
}

class UploadAvatarErrorState extends UploadAvatarState {
  final Exception errorsResponse;

  const UploadAvatarErrorState(this.errorsResponse);

  @override
  List<Object> get props => [errorsResponse];
}