import 'package:bloc/bloc.dart';
import 'package:blook_app_flutter/models/edit_user_dto.dart';
import 'package:blook_app_flutter/models/user_dto.dart';
import 'package:blook_app_flutter/repository/user_repository/user_repository.dart';
import 'package:equatable/equatable.dart';

import '../../models/error_response.dart';

part 'edit_user_event.dart';
part 'edit_user_state.dart';

class EditUserBloc extends Bloc<EditUserEvent, EditUserState> {
  final UserRepository userRepository;

  EditUserBloc(this.userRepository) : super(EditUserInitial()) {
    on<EditOneUserEvent>(_editProfile);
  }

 void _editProfile(EditOneUserEvent event, Emitter<EditUserState> emit) async {
    try {
      var user = await userRepository.edit(event.editUserDto, event.id);

      emit(EditUserSuccessState(user));
    }on ErrorResponse catch (e) {
      emit(EditUserErrorState(e));
    }
  }
}