import 'package:bloc/bloc.dart';
import 'package:blook_app_flutter/utils/preferences.dart';
import 'package:equatable/equatable.dart';
import 'package:blook_app_flutter/models/login_dto.dart';
import 'package:blook_app_flutter/models/login_response.dart';
import 'package:blook_app_flutter/repository/auth_repository/auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc(this.authRepository) : super(LoginInitialState()) {
    on<DoLoginEvent>(_doLoginEvent);
  }

  void _doLoginEvent(DoLoginEvent event, Emitter<LoginState> emit) async {
    try {
      final loginResponse = await authRepository.login(event.loginDto);
      PreferenceUtils.setString('token', loginResponse.token);
      emit(LoginSuccessState(loginResponse));
      return;
    } on Exception catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }
}