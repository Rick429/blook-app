import 'package:bloc/bloc.dart';
import 'package:blook_app_flutter/models/user_dto.dart';
import 'package:blook_app_flutter/repository/user_repository/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository userRepository;
  
  ProfileBloc(this.userRepository) : super(ProfileInitial()) {
    on<FetchUserLogged>(_userLoggedFetched);
  }

  void _userLoggedFetched(FetchUserLogged event, Emitter<ProfileState> emit) async {
    try {
      final userLogged = await userRepository.userLogged();
      emit(UserLoggedFetched(userLogged));
      return;
    } on Exception catch (e) {
      emit(UserLoggedFetchError(e.toString()));
    }
  }
}
