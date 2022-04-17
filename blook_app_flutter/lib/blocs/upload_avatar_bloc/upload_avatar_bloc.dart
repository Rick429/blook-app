import 'package:bloc/bloc.dart';
import 'package:blook_app_flutter/models/user_dto.dart';
import 'package:blook_app_flutter/repository/user_repository/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'upload_avatar_event.dart';
part 'upload_avatar_state.dart';

class UploadAvatarBloc extends Bloc<UploadAvatarEvent, UploadAvatarState> {
  final UserRepository userRepository;

  UploadAvatarBloc(this.userRepository) : super(UploadAvatarInitial()) {
    on<AvatarUploadEvent>(_uploadAvatarEvent);
  }

  void _uploadAvatarEvent(AvatarUploadEvent event, Emitter<UploadAvatarState> emit) async {
    try {
      final user = await userRepository.uploadAvatar(event.filename);
      emit(UploadAvatarSuccessState(user));
      return;
    } on Exception catch (e) {
      emit(UploadAvatarErrorState(e));
    }
  }
}
