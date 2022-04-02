import 'package:blook_app_flutter/screens/login_screen.dart';
import 'package:blook_app_flutter/screens/menu_screen.dart';
import 'package:blook_app_flutter/utils/preferences.dart';
import 'package:flutter/material.dart';

void main() {
  PreferenceUtils.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blook App Flutter',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      initialRoute: '/login',
      routes: {
        '/': (context) => const MenuScreen(),
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}
