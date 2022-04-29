import 'package:blook_app_flutter/ui/book_new_screen.dart';
import 'package:blook_app_flutter/ui/change_password_screen.dart';
import 'package:blook_app_flutter/ui/chapter_new_screen.dart';
import 'package:blook_app_flutter/ui/comments_screen.dart';
import 'package:blook_app_flutter/ui/login_screen.dart';
import 'package:blook_app_flutter/ui/menu_book_screen.dart';
import 'package:blook_app_flutter/ui/menu_screen.dart';
import 'package:blook_app_flutter/ui/register_screen.dart';
import 'package:blook_app_flutter/ui/report_screen.dart';
import 'package:blook_app_flutter/ui/search_screen.dart';
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
        '/register':(context) => const RegisterScreen(),
        '/changepassword':(context) => const ChangePasswordScreen(),
        '/search':(context) => const SearchScreen(),
        '/book':(context) => const MenuBookScreen(),
        '/booknew':(context) => const BookNewScreen(),
        '/chapternew':(context) => const ChapterNewScreen(),
        '/comments':(context) => const CommentsScren(),
        '/report':(context) => const ReportScreen(),
        
      },
    );
  }
}
