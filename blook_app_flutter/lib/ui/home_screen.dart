import 'package:blook_app_flutter/utils/preferences.dart';
import 'package:blook_app_flutter/utils/styles.dart';
import 'package:blook_app_flutter/widgets/home_app_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      body: ListView(scrollDirection: Axis.vertical, children: [
        Stack(
          children: [
            Image.asset(
              "assets/images/portada.jpg",
              height: 350,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 230),
              child: Text(
                "HARRY POTTER",
                style: BlookStyle.textCustom(
                    BlookStyle.whiteColor, BlookStyle.textSizeSix),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 300),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      margin: const EdgeInsets.all(4),
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          border: Border.all(color: BlookStyle.whiteColor),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        "Fantasia",
                        style: BlookStyle.textCustom(
                            BlookStyle.whiteColor, BlookStyle.textSizeThree),
                      )),
                  Container(
                      margin: const EdgeInsets.all(4),
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          border: Border.all(color: BlookStyle.whiteColor),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        "Fantasia",
                        style: BlookStyle.textCustom(
                            BlookStyle.whiteColor, BlookStyle.textSizeThree),
                      )),
                  Container(
                      margin: const EdgeInsets.all(4),
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          border: Border.all(color: BlookStyle.whiteColor),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        "Fantasia",
                        style: BlookStyle.textCustom(
                            BlookStyle.whiteColor, BlookStyle.textSizeThree),
                      )),
                ],
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              width: 130,
              child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Leer",
                    style: BlookStyle.textCustom(
                        BlookStyle.whiteColor, BlookStyle.textSizeFour),
                  )),
            ),
            const Icon(
              Icons.favorite,
              color: BlookStyle.whiteColor,
            )
          ],
        ),
        Text("Populares",
            style: BlookStyle.textCustom(
                BlookStyle.whiteColor, BlookStyle.textSizeFour)),
        Container(
          padding: const EdgeInsets.only(top: 8),
          width: MediaQuery.of(context).size.width,
          height: 260,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          "assets/images/portada.jpg",
                          width: 130,
                          height: 200,
                          fit: BoxFit.cover,
                        )),
                  ),
                  Text("Harry potter",
                      style: BlookStyle.textCustom(
                          BlookStyle.whiteColor, BlookStyle.textSizeTwo))
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          "assets/images/portada.jpg",
                          width: 130,
                          height: 200,
                          fit: BoxFit.cover,
                        )),
                  ),
                  Text("Harry potter",
                      style: BlookStyle.textCustom(
                          BlookStyle.whiteColor, BlookStyle.textSizeTwo))
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          "assets/images/portada.jpg",
                          width: 130,
                          height: 200,
                          fit: BoxFit.cover,
                        )),
                  ),
                  Text("Harry potter",
                      style: BlookStyle.textCustom(
                          BlookStyle.whiteColor, BlookStyle.textSizeTwo))
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          "assets/images/portada.jpg",
                          width: 130,
                          height: 200,
                          fit: BoxFit.cover,
                        )),
                  ),
                  Text("Harry potter",
                      style: BlookStyle.textCustom(
                          BlookStyle.whiteColor, BlookStyle.textSizeTwo))
                ],
              ),
            ],
          ),
        ),
        Text("Añadidos Recientemente",
            style: BlookStyle.textCustom(
                BlookStyle.whiteColor, BlookStyle.textSizeFour)),
        Container(
          padding: const EdgeInsets.all(8),
          width: MediaQuery.of(context).size.width,
          height: 260,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          "assets/images/portada.jpg",
                          width: 130,
                          height: 200,
                          fit: BoxFit.cover,
                        )),
                  ),
                  Text("Harry potter",
                      style: BlookStyle.textCustom(
                          BlookStyle.whiteColor, BlookStyle.textSizeTwo))
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          "assets/images/portada.jpg",
                          width: 130,
                          height: 200,
                          fit: BoxFit.cover,
                        )),
                  ),
                  Text("Harry potter",
                      style: BlookStyle.textCustom(
                          BlookStyle.whiteColor, BlookStyle.textSizeTwo))
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          "assets/images/portada.jpg",
                          width: 130,
                          height: 200,
                          fit: BoxFit.cover,
                        )),
                  ),
                  Text("Harry potter",
                      style: BlookStyle.textCustom(
                          BlookStyle.whiteColor, BlookStyle.textSizeTwo))
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          "assets/images/portada.jpg",
                          width: 130,
                          height: 200,
                          fit: BoxFit.cover,
                        )),
                  ),
                  Text("Harry potter",
                      style: BlookStyle.textCustom(
                          BlookStyle.whiteColor, BlookStyle.textSizeTwo))
                ],
              ),
            ],
          ),
        )
      ]),
    );
  }
}
