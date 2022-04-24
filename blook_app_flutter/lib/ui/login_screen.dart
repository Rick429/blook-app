import 'package:blook_app_flutter/blocs/login_bloc/login_bloc.dart';
import 'package:blook_app_flutter/models/login_dto.dart';
import 'package:blook_app_flutter/repository/auth_repository/auth_repository.dart';
import 'package:blook_app_flutter/repository/auth_repository/auth_repository_impl.dart';
import 'package:blook_app_flutter/ui/menu_screen.dart';
import 'package:blook_app_flutter/utils/preferences.dart';
import 'package:blook_app_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthRepository authRepository;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    PreferenceUtils.init();
    authRepository = AuthRepositoryImpl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          return LoginBloc(authRepository);
        },
        child: _createBody(context));
  }

  Widget _createBody(BuildContext context) {
    return Scaffold(
      backgroundColor: BlookStyle.blackColor,
      body: Center(
        child: Container(
            padding: const EdgeInsets.all(20),
            child: BlocConsumer<LoginBloc, LoginState>(
                listenWhen: (context, state) {
              return state is LoginSuccessState || state is LoginErrorState;
            }, listener: (context, state) {
              if (state is LoginSuccessState) {
                
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MenuScreen()),
                );
              } else if (state is LoginErrorState) {
                _showSnackbar(context, state.message);
              }
            }, buildWhen: (context, state) {
              return state is LoginInitialState || state is LoginLoadingState;
            }, builder: (ctx, state) {
              if (state is LoginInitialState) {
                return buildForm(ctx);
              } else if (state is LoginLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return buildForm(ctx);
              }
            })),
      ),
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget buildForm(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: const EdgeInsets.only(top: 140),
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
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Icon(Icons.mail_outline),
                      ),
                      hintText: 'correo electrónico',
                    ),
                    onSaved: (String? value) {},
                    validator: (String? value) {
                      return (value == null)
                          ? 'Introduzca su correo electrónico'
                          : null;
                    },
                  ),
                ),
                Container(
                  height: 50,
                  margin: const EdgeInsets.only(top: 20),
                  child: TextFormField(
                    style: BlookStyle.textCustom(
                        BlookStyle.whiteColor, BlookStyle.textSizeTwo),
                    controller: passwordController,
                    obscureText: true,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: BlookStyle.greyBoxColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      hintStyle: BlookStyle.textCustom(
                          BlookStyle.formColor, BlookStyle.textSizeTwo),
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Icon(Icons.lock_outlined),
                      ),
                      hintText: 'Contraseña',
                    ),
                    onSaved: (String? value) {},
                    validator: (value) {
                      return (value == null || value.isEmpty)
                          ? 'Escribe tu contraseña'
                          : null;
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 180),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(100)),
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
                          final loginDto = LoginDto(
                              email: emailController.text,
                              password: passwordController.text);
                          BlocProvider.of<LoginBloc>(context)
                              .add(DoLoginEvent(loginDto));
                        }            
                      },
                      child: Text(
                        'Iniciar Sesión',
                        style: BlookStyle.textCustom(
                            BlookStyle.whiteColor, BlookStyle.textSizeThree),
                        textAlign: TextAlign.center,
                      )),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: GestureDetector(
                    child: Text(
                      '¿No tienes cuenta? Registrate',
                      style: BlookStyle.textCustom(
                          BlookStyle.whiteColor, BlookStyle.textSizeThree),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/register');
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
