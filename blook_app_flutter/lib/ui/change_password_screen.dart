import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:blook_app_flutter/blocs/change_password_bloc/change_password_bloc.dart';
import 'package:blook_app_flutter/models/password_dto.dart';
import 'package:blook_app_flutter/repository/user_repository/user_repository.dart';
import 'package:blook_app_flutter/repository/user_repository/user_repository_impl.dart';
import 'package:blook_app_flutter/ui/menu_screen.dart';
import 'package:blook_app_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/error_response.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  TextEditingController password3Controller = TextEditingController();
  late UserRepository userRepository;

  @override
  void initState() {
    userRepository = UserRepositoryImpl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ChangePasswordBloc(userRepository)),
      ],
      child: Scaffold(
        backgroundColor: BlookStyle.blackColor,
        appBar: AppBar(
          title: Text(
            "CAMBIAR CONTRASEÑA",
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
            child: _createBody(context),
          ),
        ),
      ),
    );
  }

  Widget _createBody(BuildContext context) {
    return BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
      listenWhen: (context, state) {
        return state is ChangePasswordSuccessState ||
            state is ChangePasswordErrorState;
      },
      listener: (context, state) {
        if (state is ChangePasswordSuccessState) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MenuScreen()),
          );
          _createDialog(context);
        } else if (state is ChangePasswordErrorState) {
          _showSnackbar(context, state.error);
        }
      },
      buildWhen: (context, state) {
        return state is ChangePasswordInitial ||
            state is ChangePasswordSuccessState;
      },
      builder: (context, state) {
        if (state is ChangePasswordSuccessState) {
          return buildF(context);
        }
        return buildF(context);
      },
    );
  }

  AwesomeDialog _createDialog(context) {
    return AwesomeDialog(
      context: context,
      dialogBackgroundColor: BlookStyle.quaternaryColor,
      btnOkColor: BlookStyle.primaryColor,
      dialogType: DialogType.SUCCES,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Correcto',
      desc: 'La contraseña se ha guardado correctamente',
      titleTextStyle:
          BlookStyle.textCustom(BlookStyle.whiteColor, BlookStyle.textSizeFour),
      descTextStyle: BlookStyle.textCustom(
          BlookStyle.whiteColor, BlookStyle.textSizeThree),
      btnOkText: "Aceptar",
      btnOkOnPress: () {},
    )..show();
  }

  void _showSnackbar(BuildContext context, ErrorResponse error) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 4),
      content: SizedBox(
        height: 150,
        child: Column(
          children: [for (SubErrores e in error.subErrores) Text(e.mensaje)],
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget buildF(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 500,
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
                  controller: passwordController,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: BlookStyle.greyBoxColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    hintStyle: BlookStyle.textCustom(
                        BlookStyle.formColor, BlookStyle.textSizeTwo),
                    hintText: 'Contraseña actual:',
                  ),
                  onSaved: (String? value) {},
                  validator: (String? value) {
                    return (value == null)
                        ? 'Introduzca su contraseña actual'
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
                  controller: password2Controller,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: BlookStyle.greyBoxColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    hintStyle: BlookStyle.textCustom(
                        BlookStyle.formColor, BlookStyle.textSizeTwo),
                    hintText: 'Nueva contraseña:',
                  ),
                  onSaved: (String? value) {},
                  validator: (String? value) {
                    return (value == null)
                        ? 'Introduzca su nueva contraseña'
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
                  controller: password3Controller,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: BlookStyle.greyBoxColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    hintStyle: BlookStyle.textCustom(
                        BlookStyle.formColor, BlookStyle.textSizeTwo),
                    hintText: 'Confirmar contraseña nueva:',
                  ),
                  onSaved: (String? value) {},
                  validator: (String? value) {
                    return (value == null)
                        ? 'Repita su contraseña nueva'
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
                      final passwordDto = PasswordDto(
                          password: passwordController.text,
                          passwordNew: password2Controller.text,
                          passwordNew2: password3Controller.text);
                      BlocProvider.of<ChangePasswordBloc>(context)
                          .add(ChangePassEvent(passwordDto));
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
