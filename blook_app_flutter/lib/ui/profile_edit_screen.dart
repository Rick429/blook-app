import 'package:blook_app_flutter/blocs/change_password_bloc/change_password_bloc.dart';
import 'package:blook_app_flutter/blocs/edit_user_bloc/edit_user_bloc.dart';
import 'package:blook_app_flutter/models/edit_user_dto.dart';
import 'package:blook_app_flutter/models/password_dto.dart';
import 'package:blook_app_flutter/repository/user_repository/user_repository.dart';
import 'package:blook_app_flutter/repository/user_repository/user_repository_impl.dart';
import 'package:blook_app_flutter/ui/menu_screen.dart';
import 'package:blook_app_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileEditScreen extends StatefulWidget {
  final String name;
  final String lastName;
  final String email;
  final String id;
  const ProfileEditScreen({Key? key, required this.name, required this.lastName, required this.email, required this.id}) : super(key: key);

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late UserRepository userRepository;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.name);
    lastNameController = TextEditingController(text: widget.lastName);
    emailController = TextEditingController(text: widget.email);
    userRepository = UserRepositoryImpl();
    super.initState();
  }

   @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => EditUserBloc(userRepository)),
        ],
        child: Scaffold(
      backgroundColor: BlookStyle.blackColor,
      appBar: AppBar(
        title:  Text(
                    "EDITAR PERFIL",
                    style: BlookStyle.textCustom(
                        BlookStyle.whiteColor, BlookStyle.textSizeFive),
                  ),
                  centerTitle: true,
        backgroundColor: BlookStyle.blackColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
            body: RefreshIndicator(
                onRefresh: () async {},
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    child: _createBody(context)))));
  }

  Widget _createBody(BuildContext context) {
    return 
      BlocConsumer<EditUserBloc, EditUserState>(
          listenWhen: (context, state) {
            return state is EditUserSuccessState;
          },
           listener: (context, state) {
            if (state is EditUserSuccessState) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MenuScreen()),
              );
            } else if (state is EditUserErrorState) {
              _showSnackbar(context, state.message);
            }
          },
          buildWhen: (context, state) {
            return state is EditUserInitial || state is EditUserSuccessState;
          },
          builder: (context, state) {
            if (state is EditUserSuccessState) {
              return buildF(context);
            }
            return buildF(context);
          });
    
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


  Widget buildF(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 600,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  height: 50,
                  margin: const EdgeInsets.all(10),
                  child: TextFormField(
                    style: BlookStyle.textCustom(
                        BlookStyle.whiteColor, BlookStyle.textSizeTwo),
                    controller: nameController,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: BlookStyle.greyBoxColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      hintStyle: BlookStyle.textCustom(
                          BlookStyle.formColor, BlookStyle.textSizeTwo),
                      hintText: 'Nombre:',
                    ),
                    onSaved: (String? value) {},
                    validator: (String? value) {
                      return (value == null)
                          ? 'Introduzca un nombre'
                          : null;
                    },
                  ),
                ),
                Container(
                  height: 50,
                  margin: const EdgeInsets.all(10),
                  child: TextFormField(
                    style: BlookStyle.textCustom(
                        BlookStyle.whiteColor, BlookStyle.textSizeTwo),
                    controller: lastNameController,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: BlookStyle.greyBoxColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      hintStyle: BlookStyle.textCustom(
                          BlookStyle.formColor, BlookStyle.textSizeTwo),
                      hintText: 'Apellidos:',
                    ),
                    onSaved: (String? value) {},
                    validator: (String? value) {
                      return (value == null)
                          ? 'Introduzca sus apellidos'
                          : null;
                    },
                  ),
                ),
                Container(
                  height: 50,
                  margin: const EdgeInsets.all(10),
                  child: TextFormField(
                    style: BlookStyle.textCustom(
                        BlookStyle.whiteColor, BlookStyle.textSizeTwo),
                    controller: emailController,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: BlookStyle.greyBoxColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      hintStyle: BlookStyle.textCustom(
                          BlookStyle.formColor, BlookStyle.textSizeTwo),
                      hintText: 'Email:',
                    ),
                    onSaved: (String? value) {},
                    validator: (String? value) {
                      return (value == null)
                          ? 'Introduzca su email'
                          : null;
                    },
                  ),
                ),
                Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.fromLTRB(10, 200, 10, 8),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: BlookStyle.primaryColor,
                      elevation: 15.0,
                    ),
                    onPressed: () {
                  final edit = EditUserDto( 
                    name: nameController.text, 
                    lastname: lastNameController.text,
                    email: emailController.text);
                      BlocProvider.of<EditUserBloc>(context).add(EditOneUserEvent(edit, widget.id
                          ),
                        );
                    },
                    child: Text("Guardar",
                        style: BlookStyle.textCustom(
                            BlookStyle.whiteColor, BlookStyle.textSizeThree))),
              )
              ],
            ),
          ),
      ),
    );
  }
}
