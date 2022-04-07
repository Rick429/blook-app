import 'package:blook_app_flutter/utils/preferences.dart';
import 'package:blook_app_flutter/utils/styles.dart';
import 'package:blook_app_flutter/widgets/home_app_bar.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    PreferenceUtils.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: BlookStyle.blackColor,
        appBar: const HomeAppBar(),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Center(
              child: Text("FAVORITOS",
                  style: BlookStyle.textCustom(
                      BlookStyle.whiteColor, BlookStyle.textSizeFive)),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: BlookStyle.quaternaryColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "Ordenado por: nombre",
                      style: BlookStyle.textCustom(
                          BlookStyle.whiteColor, BlookStyle.textSizeTwo),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.filter_list,
                      color: BlookStyle.whiteColor,
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: BlookStyle.quaternaryColor,
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          "assets/images/portada.jpg",
                          width: 130,
                          height: 200,
                          fit: BoxFit.cover,
                        )),
                  ),
                  SizedBox(
                    height: 140,
                    child: Text(
                      "Harry potter",
                      style: BlookStyle.textCustom(
                          BlookStyle.whiteColor, BlookStyle.textSizeTwo),
                      textAlign: TextAlign.start,
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: BlookStyle.quaternaryColor,
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          "assets/images/portada.jpg",
                          width: 130,
                          height: 200,
                          fit: BoxFit.cover,
                        )),
                  ),
                  SizedBox(
                    height: 140,
                    child: Text(
                      "Harry potter",
                      style: BlookStyle.textCustom(
                          BlookStyle.whiteColor, BlookStyle.textSizeTwo),
                      textAlign: TextAlign.start,
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: BlookStyle.quaternaryColor,
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          "assets/images/portada.jpg",
                          width: 130,
                          height: 200,
                          fit: BoxFit.cover,
                        )),
                  ),
                  SizedBox(
                    height: 140,
                    child: Text(
                      "Harry potter",
                      style: BlookStyle.textCustom(
                          BlookStyle.whiteColor, BlookStyle.textSizeTwo),
                      textAlign: TextAlign.start,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
  }
}
