import 'package:blook_app_flutter/constants.dart';
import 'package:blook_app_flutter/ui/book_screen.dart';
import 'package:blook_app_flutter/ui/comments_screen.dart';
import 'package:blook_app_flutter/ui/pdf_viewer.dart';
import 'package:blook_app_flutter/ui/report_screen.dart';
import 'package:blook_app_flutter/utils/preferences.dart';
import 'package:blook_app_flutter/utils/styles.dart';
import 'package:flutter/material.dart';

class MenuBookScreen extends StatefulWidget {
  const MenuBookScreen({Key? key}) : super(key: key);

  @override
  _MenuBookScreenState createState() => _MenuBookScreenState();
}

class _MenuBookScreenState extends State<MenuBookScreen> {
  int _currentIndex = 0;

  List<Widget> pages = [
    const BookScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: BlookStyle.quaternaryColor,
        body: pages[_currentIndex],
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
              child: Container(
                width: 150,
                margin: const EdgeInsets.all(8),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: BlookStyle.primaryColor,
                      elevation: 15.0,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PdfViewer(
                              document: PreferenceUtils.getString("document") ??
                                  "")));
                    },
                    child: Text("Leer",
                        style: BlookStyle.textCustom(
                            BlookStyle.whiteColor, BlookStyle.textSizeThree))),
              ),
              onTap: () {
                setState(() {
                  _currentIndex = 0;
                });
              },
            ),
            GestureDetector(
              child: Icon(Icons.comment,
                  color: _currentIndex == 1
                      ? BlookStyle.primaryColor
                      : BlookStyle.whiteColor),
              onTap: () {
                Navigator.pushNamed(context, '/comments');
              },
            ),
            GestureDetector(
              child: Icon(Icons.report_problem_rounded,
                  color: _currentIndex == 2
                      ? BlookStyle.primaryColor
                      : BlookStyle.whiteColor),
              onTap: () {
                PreferenceUtils.setString(Constant.typereport, "LIBRO");
                Navigator.pushNamed(context, '/report');
              },
            ),
          ],
        ));
  }
}
