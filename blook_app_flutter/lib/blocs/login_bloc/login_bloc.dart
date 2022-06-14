import 'package:bloc/bloc.dart';
import 'package:blook_app_flutter/utils/preferences.dart';
import 'package:equatable/equatable.dart';
import 'package:blook_app_flutter/models/login_dto.dart';
import 'package:blook_app_flutter/models/login_response.dart';
import 'package:blook_app_flutter/repository/auth_repository/auth_repository.dart';
import 'package:get_storage/get_storage.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  final box = GetStorage();
  LoginBloc(this.authRepository) : super(LoginInitialState()) {
    on<DoLoginEvent>(_doLoginEvent);
  }

  void _doLoginEvent(DoLoginEvent event, Emitter<LoginState> emit) async {
    try {
      final loginResponse = await authRepository.login(event.loginDto);
      box.write('token', loginResponse.token);
      box.write('nick', loginResponse.token);
      emit(LoginSuccessState(loginResponse));
      return;
    } on Exception catch (e) {
      emit(const LoginErrorState("El correo electrónico o la contraseña introducidos son incorrectos"));
    }
  }
}