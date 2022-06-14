import 'package:blook_app_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: BlookStyle.blackColor,
      padding: const EdgeInsets.fromLTRB(10,50,10,20),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Expanded(
          flex: 0,
          child: SvgPicture.asset('assets/images/logo.svg', width: 100,
          ),
        ),
        Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                      Navigator.pushNamed(context, '/search');
                    },
                  child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.search, color: BlookStyle.whiteColor,),
                  ),
                ),
                 GestureDetector(
                  onTap: () {
                      Navigator.pushNamed(context, '/booknew');
                    },
                  child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.add, color: BlookStyle.whiteColor),
                  ),
                ),
              ],
            ))
      ]),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
