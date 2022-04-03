import 'package:bloc/bloc.dart';
import 'package:blook_app_flutter/models/login_response.dart';
import 'package:blook_app_flutter/models/register_dto.dart';
import 'package:blook_app_flutter/repository/auth_repository/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository authRepository;

  RegisterBloc(this.authRepository) : super(RegisterInitial()) {
    on<DoRegisterEvent>(_doRegisterEvent);
  }

  void _doRegisterEvent(DoRegisterEvent event, Emitter<RegisterState> emit) async {
    try {
      final loginResponse = await authRepository.register(event.registerDto);
      emit(RegisterSuccessState(loginResponse));
      return;
    } on Exception catch (e) {
      emit(RegisterErrorState(e));
    }
  }

}
