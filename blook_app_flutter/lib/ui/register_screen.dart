import 'dart:io';

import 'package:blook_app_flutter/blocs/register_bloc/register_bloc.dart';
import 'package:blook_app_flutter/constants.dart';
import 'package:blook_app_flutter/models/register_dto.dart';
import 'package:blook_app_flutter/repository/auth_repository/auth_repository.dart';
import 'package:blook_app_flutter/repository/auth_repository/auth_repository_impl.dart';
import 'package:blook_app_flutter/ui/menu_screen.dart';
import 'package:blook_app_flutter/utils/preferences.dart';
import 'package:blook_app_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/error_response.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nickController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  late AuthRepository authRepository;
  bool _obscureText = true;
  Icon iconpass = const Icon(Icons.remove_red_eye_outlined);

  @override
  void initState() {
    super.initState();
    authRepository = AuthRepositoryImpl();
    PreferenceUtils.init();
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: BlookStyle.quaternaryColor,
            content: const Text(
              '¿Deseas salir de la aplicación?',
              style: TextStyle(
                color: BlookStyle.whiteColor,
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text(
                      'No',
                      style: TextStyle(
                        color: BlookStyle.whiteColor,
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () => exit(0),
                      child: const Text(
                        'Si',
                        style: TextStyle(
                          color: BlookStyle.whiteColor,
                        ),
                      )),
                ],
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          return RegisterBloc(authRepository);
        },
        child: WillPopScope(
          onWillPop: _onWillPop,
          child: Scaffold(
              backgroundColor: BlookStyle.blackColor,
              body: RefreshIndicator(
                  onRefresh: () async {},
                  child: SingleChildScrollView(child: _createBody(context)))),
        ));
  }

  Widget _createBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 70.0),
      child: Column(children: [
        BlocConsumer<RegisterBloc, RegisterState>(listenWhen: (context, state) {
          return state is RegisterSuccessState || state is RegisterErrorState;
        }, listener: (context, state) {
          if (state is RegisterSuccessState) {
            PreferenceUtils.setString(
                Constant.token, state.loginResponse.token);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MenuScreen()),
            );
          } else if (state is RegisterErrorState) {
            _showSnackbar(context, state.error);
          }
        }, buildWhen: (context, state) {
          return state is RegisterInitial || state is RegisterLoadingState;
        }, builder: (ctx, state) {
          if (state is RegisterInitial) {
            return buildF(ctx);
          } else if (state is RegisterLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return buildF(ctx);
          }
        }),
      ]),
    );
  }

  void _showSnackbar(BuildContext context, ErrorResponse error) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 4),
      content: SizedBox(
        height: 150,
        child: Column(
          children: [
            Text(error.mensaje),
            for (SubErrores e in error.subErrores) Text(e.mensaje)
          ],
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
      if (_obscureText) {
        iconpass = const Icon(Icons.remove_red_eye_outlined);
      } else {
        iconpass = const Icon(Icons.remove_red_eye);
      }
    });
  }

  Widget buildF(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Center(
        child: Container(
          margin: const EdgeInsets.only(top: 60),
          width: 300,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/logo.svg',
                  width: 250,
                ),
                Container(
                  height: 50,
                  margin: const EdgeInsets.only(top: 50),
                  child: TextFormField(
                    style: BlookStyle.textCustom(
                        BlookStyle.whiteColor, BlookStyle.textSizeTwo),
                    controller: nickController,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: BlookStyle.greyBoxColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      hintStyle: BlookStyle.textCustom(
                          BlookStyle.formColor, BlookStyle.textSizeTwo),
                      hintText: 'Nombre de usuario',
                    ),
                    onSaved: (String? value) {},
                    validator: (value) {
                      return (value == null || value.isEmpty)
                          ? 'Escribe un nombre de usuario'
                          : null;
                    },
                  ),
                ),
                Container(
                  height: 50,
                  margin: const EdgeInsets.only(top: 10),
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
                      hintText: 'Nombre',
                    ),
                    onSaved: (String? value) {},
                    validator: (value) {
                      return (value == null || value.isEmpty)
                          ? 'Escribe tu nombre'
                          : null;
                    },
                  ),
                ),
                Container(
                  height: 50,
                  margin: const EdgeInsets.only(top: 10),
                  child: TextFormField(
                    style: BlookStyle.textCustom(
                        BlookStyle.whiteColor, BlookStyle.textSizeTwo),
                    controller: lastnameController,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: BlookStyle.greyBoxColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      hintStyle: BlookStyle.textCustom(
                          BlookStyle.formColor, BlookStyle.textSizeTwo),
                      hintText: 'Apellidos',
                    ),
                    onSaved: (String? value) {},
                    validator: (value) {
                      return (value == null || value.isEmpty)
                          ? 'Escribe tus apellidos'
                          : null;
                    },
                  ),
                ),
                Container(
                  height: 50,
                  margin: const EdgeInsets.only(top: 10),
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
                      hintText: 'correo electrónico',
                    ),
                    onSaved: (String? value) {},
                    validator: (String? value) {
                      return (value == null || !value.contains('@'))
                          ? 'El correo debe contener una @'
                          : null;
                    },
                  ),
                ),
                Container(
                  height: 50,
                  margin: const EdgeInsets.only(top: 10),
                  child: TextFormField(
                    style: BlookStyle.textCustom(
                        BlookStyle.whiteColor, BlookStyle.textSizeTwo),
                    controller: passwordController,
                    obscureText: _obscureText,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: BlookStyle.greyBoxColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      suffixIcon: GestureDetector(
                          onTap: () {
                            _toggle();
                          },
                          child: iconpass),
                      suffixIconColor: Colors.white,
                      hintStyle: BlookStyle.textCustom(
                          BlookStyle.formColor, BlookStyle.textSizeTwo),
                      hintText: 'Contraseña',
                    ),
                    onSaved: (String? value) {},
                    validator: (value) {
                      return (value == null || value.isEmpty)
                          ? 'Escribe una contraseña'
                          : null;
                    },
                  ),
                ),
                Container(
                  height: 50,
                  margin: const EdgeInsets.only(top: 10),
                  child: TextFormField(
                    style: BlookStyle.textCustom(
                        BlookStyle.whiteColor, BlookStyle.textSizeTwo),
                    controller: password2Controller,
                    obscureText: _obscureText,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: BlookStyle.greyBoxColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      suffixIcon: GestureDetector(
                          onTap: () {
                            _toggle();
                          },
                          child: iconpass),
                      suffixIconColor: Colors.white,
                      hintStyle: BlookStyle.textCustom(
                          BlookStyle.formColor, BlookStyle.textSizeTwo),
                      hintText: 'Confirmar contraseña',
                    ),
                    onSaved: (String? value) {},
                    validator: (value) {
                      return (value == null || value.isEmpty)
                          ? 'Escribe tu contraseña nuevamente'
                          : null;
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  width: 300,
                  height: 80,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: BlookStyle.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        elevation: 15.0,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final registerDto = RegisterDto(
                              nick: nickController.text,
                              name: nameController.text,
                              lastname: lastnameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              password2: password2Controller.text);
                          BlocProvider.of<RegisterBloc>(context)
                              .add(DoRegisterEvent(registerDto));
                        }
                      },
                      child: Text(
                        'Registrarse',
                        style: BlookStyle.textCustom(
                            BlookStyle.whiteColor, BlookStyle.textSizeThree),
                        textAlign: TextAlign.center,
                      )),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: GestureDetector(
                    child: Text(
                      '¿Tienes una cuenta? Inicia sesión',
                      style: BlookStyle.textCustom(
                          BlookStyle.whiteColor, BlookStyle.textSizeThree),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/login');
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
