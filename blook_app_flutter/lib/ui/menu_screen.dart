import 'dart:io';
import 'package:blook_app_flutter/ui/books_screen.dart';
import 'package:blook_app_flutter/ui/favorite_screen.dart';
import 'package:blook_app_flutter/ui/my_books_screen.dart';
import 'package:blook_app_flutter/ui/profile_screen.dart';
import 'package:blook_app_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'home_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _currentIndex = 0;

  List<Widget> pages = [
    const HomeScreen(),
    const FavoriteScreen(),
    const BooksScreen(),
    const MyBooksScreen(),
    const ProfileScreen(),
  ];
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
    return Scaffold(
        backgroundColor: BlookStyle.quaternaryColor,
        body: WillPopScope(onWillPop: _onWillPop, child: pages[_currentIndex]),
        bottomNavigationBar: _buildBottomBar());
  }

  Widget _buildBottomBar() {
    return Container(
        decoration: const BoxDecoration(
            border: Border(
          top: BorderSide(
            color: BlookStyle.quaternaryColor,
            width: 1.0,
          ),
        )),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              child: Icon(Icons.home,
                  color: _currentIndex == 0
                      ? BlookStyle.primaryColor
                      : BlookStyle.whiteColor),
              onTap: () {
                setState(() {
                  _currentIndex = 0;
                });
              },
            ),
            GestureDetector(
              child: Icon(Icons.favorite,
                  color: _currentIndex == 1
                      ? BlookStyle.primaryColor
                      : BlookStyle.whiteColor),
              onTap: () {
                setState(() {
                  _currentIndex = 1;
                });
              },
            ),
            GestureDetector(
              child: SvgPicture.asset("assets/images/books.svg",height: 30,
                  color: _currentIndex == 2
                      ? BlookStyle.primaryColor
                      : BlookStyle.whiteColor),
              onTap: () {
                setState(() {
                  _currentIndex = 2;
                });
              },
            ),
            GestureDetector(
              child: SvgPicture.asset("assets/images/book.svg",height: 30,
                  color: _currentIndex == 3
                      ? BlookStyle.primaryColor
                      : BlookStyle.whiteColor),
              onTap: () {
                setState(() {
                  _currentIndex = 3;
                });
              },
            ),
            GestureDetector(
              child: Icon(Icons.person,
                  color: _currentIndex == 4
                      ? BlookStyle.primaryColor
                      : BlookStyle.whiteColor),
              onTap: () {
                setState(() {
                  _currentIndex = 4;
                });
              },
            ),
          ],
        ));
  }
}
