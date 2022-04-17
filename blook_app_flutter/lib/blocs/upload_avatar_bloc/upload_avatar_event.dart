part of 'upload_avatar_bloc.dart';

abstract class UploadAvatarEvent extends Equatable{
 const UploadAvatarEvent();

  @override
  List<Object> get props => [];
}

class AvatarUploadEvent extends UploadAvatarEvent {

  final String filename;

  const AvatarUploadEvent(this.filename);

}
