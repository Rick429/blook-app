import 'package:bloc/bloc.dart';
import 'package:blook_app_flutter/constants.dart';
import 'package:blook_app_flutter/repository/user_repository/user_repository.dart';
import 'package:blook_app_flutter/utils/preferences.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'image_pick_event.dart';
part 'image_pick_state.dart';

class ImagePickBloc extends Bloc<ImagePickEvent, ImagePickState> {
  final UserRepository userRepository;
  ImagePickBloc(this.userRepository) : super(ImagePickInitial()) {
    on<SelectImageEvent>(_onSelectImage);
  }

  void _onSelectImage(SelectImageEvent event, Emitter<ImagePickState> emit) async {
    final ImagePicker _picker = ImagePicker();

    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: event.source,
      );
      if (pickedFile != null) {
        final user = await userRepository.uploadAvatar(pickedFile.path);
        PreferenceUtils.setString(Constant.avatar, user.avatar);
        emit(ImageSelectedSuccessState(pickedFile));
      } else {
        emit(const ImageSelectedErrorState('Error in image selection'));
      }
    } catch (e) {
      emit(const ImageSelectedErrorState('Error in image selection'));
    }
  }

}