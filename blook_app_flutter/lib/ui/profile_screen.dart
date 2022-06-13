import 'dart:convert';
import 'dart:io';
import 'package:blook_app_flutter/blocs/profile_bloc/profile_bloc.dart';
import 'package:blook_app_flutter/models/user_dto.dart';
import 'package:blook_app_flutter/repository/user_repository/user_repository.dart';
import 'package:blook_app_flutter/repository/user_repository/user_repository_impl.dart';
import 'package:blook_app_flutter/ui/profile_edit_screen.dart';
import 'package:blook_app_flutter/widgets/error_page.dart';
import 'package:flutter/material.dart';
import 'package:blook_app_flutter/blocs/image_pick_bloc/image_pick_bloc.dart';
import 'package:blook_app_flutter/constants.dart';
import 'package:blook_app_flutter/utils/styles.dart';
import 'package:blook_app_flutter/widgets/home_app_bar.dart';
import '../utils/preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality);

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<XFile>? _imageFileList;
  late UserRepository userRepository;
  late ProfileBloc _profileBloc;

  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : <XFile>[value];
  }

  var url = "https://i.ibb.co/RDRz7Ft/upload.png";

  @override
  void initState() {
    userRepository = UserRepositoryImpl();
    PreferenceUtils.init();
    _profileBloc = ProfileBloc(userRepository)..add(FetchUserLogged());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _profileBloc),
        BlocProvider(create: (context) => ImagePickBloc(userRepository))
      ],
      child: Scaffold(
        backgroundColor: BlookStyle.blackColor,
        appBar: const HomeAppBar(),
        body: RefreshIndicator(
          onRefresh: () async {},
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: _createBody(context),
          ),
        ),
      ),
    );
  }

  Widget _createBody(BuildContext context) {
    return Column(
      children: [
        BlocProvider(
          create: (context) {
            return ImagePickBloc(userRepository);
          },
          child: BlocConsumer<ImagePickBloc, ImagePickState>(
              listenWhen: (context, state) {
                return state is ImageSelectedSuccessState;
              },
              listener: (context, state) {},
              buildWhen: (context, state) {
                return state is ImagePickInitial ||
                    state is ImageSelectedSuccessState;
              },
              builder: (context, state) {
                if (state is ImageSelectedSuccessState) {
                  return buildProfile(context, state);
                }
                return buildProfile(context, state);
              }),
        ),
        BlocBuilder<ProfileBloc, ProfileState>(
          bloc: _profileBloc,
          builder: (context, state) {
            if (state is ProfileInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserLoggedFetchError) {
              return ErrorPage(
                  message: state.message,
                  retry: () {
                    context.watch<ProfileBloc>().add(const FetchUserLogged());
                  });
            } else if (state is UserLoggedFetched) {
              return _userItem(state.userLogged);
            } else {
              return const Text('No se pudo cargar los datos');
            }
          },
        ),
      ],
    );
  }

  Widget _userItem(User userLogged) {
    PreferenceUtils.setString('idUser', userLogged.id);
    return Column(
      children: [
        Center(
          child: Center(
            child: Text(utf8.decode(userLogged.nick.codeUnits),
                style: BlookStyle.textCustom(
                    BlookStyle.whiteColor, BlookStyle.textSizeThree)),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProfileEditScreen(
                        name: userLogged.name,
                        lastName: userLogged.lastname,
                        email: userLogged.email,
                        id: userLogged.id)));
              },
              icon: const Icon(
                Icons.edit,
                color: BlookStyle.whiteColor,
              ),
            )
          ],
        ),
        Container(
          height: 40,
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: BlookStyle.greyBoxColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Nombre:",
                  style: BlookStyle.textCustom(
                      BlookStyle.whiteColor, BlookStyle.textSizeTwo),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  utf8.decode(userLogged.name.codeUnits),
                  style: BlookStyle.textCustom(
                      BlookStyle.whiteColor, BlookStyle.textSizeTwo),
                ),
              )
            ],
          ),
        ),
        Container(
          height: 40,
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: BlookStyle.greyBoxColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Apellidos:",
                  style: BlookStyle.textCustom(
                      BlookStyle.whiteColor, BlookStyle.textSizeTwo),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  utf8.decode(userLogged.lastname.codeUnits),
                  style: BlookStyle.textCustom(
                      BlookStyle.whiteColor, BlookStyle.textSizeTwo),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 40,
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: BlookStyle.greyBoxColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Correo eléctronico:",
                  style: BlookStyle.textCustom(
                      BlookStyle.whiteColor, BlookStyle.textSizeTwo),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(utf8.decode(userLogged.email.codeUnits),
                    style: BlookStyle.textCustom(
                        BlookStyle.whiteColor, BlookStyle.textSizeTwo)),
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(8),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: BlookStyle.greyBoxColor,
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: BlookStyle.formColor, width: 2),
                borderRadius: BorderRadius.circular(25),
              ),
              elevation: 15.0,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/changepassword');
            },
            child: Text(
              "Cambiar contraseña",
              style: BlookStyle.textCustom(
                  BlookStyle.whiteColor, BlookStyle.textSizeTwo),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(8, 50, 8, 8),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: BlookStyle.redColor,
              elevation: 15.0,
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: BlookStyle.quaternaryColor,
                        title: const Text("Cerrar sesión",
                                  style: TextStyle(
                                    color: BlookStyle.whiteColor,
                                  ),),
                        content: const Text('¿Estas seguro que quieres salir?',
                                  style: TextStyle(
                                    color: BlookStyle.whiteColor,
                                  ),),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: const Text('No',
                                  style: TextStyle(
                                    color: BlookStyle.whiteColor,
                                  ),),
                              ),
                              TextButton(
                                onPressed: () => {
                                  PreferenceUtils.clear(),
                                  Navigator.pushNamed(context, '/login'),
                                },
                                child: const Text(
                                  'Si',
                                  style: TextStyle(
                                    color: BlookStyle.whiteColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ));
            },
            child: Text(
              "Cerrar sesión",
              style: BlookStyle.textCustom(
                  BlookStyle.whiteColor, BlookStyle.textSizeThree),
            ),
          ),
        ),
      ],
    );
  }

  Widget avatar(String avatarUrl) {
    if (avatarUrl.isEmpty) {
      return Container(
          width: 130,
          height: 130,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/images/upload.png"))));
    } else {
      return Container(
          width: 130,
          height: 130,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                    PreferenceUtils.getString("avatar")!,
                    /*  headers: {
                            'Authorization':
                                'Bearer ${PreferenceUtils.getString('token')}'
                          }, */
                  ))));
    }
  }

  Widget buildProfile(BuildContext context, state) {
    return SizedBox(
      height: 180,
      child: Column(
        children: [
          Center(
            child: Text("MI PERFIL",
                style: BlookStyle.textCustom(
                    BlookStyle.whiteColor, BlookStyle.textSizeFive)),
          ),
          GestureDetector(
              onTap: () {
                BlocProvider.of<ImagePickBloc>(context)
                    .add(const SelectImageEvent(ImageSource.gallery));
              },
              child: avatar(PreferenceUtils.getString('avatar')!)),
        ],
      ),
    );
  }
}
