import 'package:bloc/bloc.dart';
import 'package:blook_app_flutter/models/password_dto.dart';
import 'package:blook_app_flutter/models/user_dto.dart';
import 'package:blook_app_flutter/repository/user_repository/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final UserRepository userRepository;
  
  ChangePasswordBloc(this.userRepository) : super(ChangePasswordInitial()) {
    on<ChangePassEvent>(_changepassword);
  }

  void _changepassword(ChangePassEvent event, Emitter<ChangePasswordState> emit) async {
    try {
      var user = await userRepository.changePassword(event.passwordDto);

      emit(ChangePasswordSuccessState(user));
    } catch (e) {
      emit(const ChangePasswordErrorState('Error al cambiar la contraseña'));
    }
  }
}
