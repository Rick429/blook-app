import 'package:blook_app_flutter/utils/styles.dart';
import 'package:flutter/material.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({Key? key}) : super(key: key);

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: BlookStyle.blackColor,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    "assets/images/portada.jpg",
                    height: 260,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: 260,
                  decoration:
                      BoxDecoration(color: Colors.grey.withOpacity(0.5)),
                ),
                Container(
                  height: 250,
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          "assets/images/portada.jpg",
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 40, horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Harry potter",
                              style: BlookStyle.textCustom(
                                  BlookStyle.whiteColor,
                                  BlookStyle.textSizeFive),
                            ),
                            Text(
                              "J. K Rowling",
                              style: BlookStyle.textCustom(
                                  BlookStyle.whiteColor,
                                  BlookStyle.textSizeFour),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 260,
                  width: MediaQuery.of(context).size.width,
                  child: const Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Icon(
                        Icons.edit,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "SINOPSIS",
                style: BlookStyle.textCustom(
                  BlookStyle.whiteColor,
                  BlookStyle.textSizeThree,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "En su tercer año en Hogwarts, Harry, Ron y Hermione conocen a Sirius Black, el prisionero que ha escapado de Azkaban y aprenden a acercarse a un Hippogriffo mitad caballo/ mitad águila, a como transformar a los cambiantes Boggarts y el arte de la Adivinación. Harry deberá enfrentárse a los Dementores que son ladrones de almas, defenderse del peligroso hombre lobo y lidiar con la verdad acerca de la relación entre Sirius Black y sus padres.",
                style: BlookStyle.textCustom(
                  BlookStyle.whiteColor,
                  BlookStyle.textSizeTwo,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: BlookStyle.primaryColor,
                    elevation: 15.0,
                  ),
                  onPressed: () {},
                  child: Text("Ver información",
                      style: BlookStyle.textCustom(
                          BlookStyle.whiteColor, BlookStyle.textSizeThree))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "CAPÍTULOS",
                    style: BlookStyle.textCustom(
                      BlookStyle.whiteColor,
                      BlookStyle.textSizeThree,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/chapternew');
                    },
                    child: Container(
                      width: 50,
                      height: 30,
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          color: BlookStyle.primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "+",
                        style: BlookStyle.textCustom(
                            BlookStyle.whiteColor, BlookStyle.textSizeThree),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              height: 30,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    width: 70,
                    height: 20,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: BlookStyle.quaternaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      "1-5",
                      style: BlookStyle.textCustom(
                          BlookStyle.whiteColor, BlookStyle.textSizeOne),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    width: 70,
                    height: 20,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: BlookStyle.quaternaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      "1-5",
                      style: BlookStyle.textCustom(
                          BlookStyle.whiteColor, BlookStyle.textSizeOne),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    width: 70,
                    height: 20,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: BlookStyle.quaternaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      "1-5",
                      style: BlookStyle.textCustom(
                          BlookStyle.whiteColor, BlookStyle.textSizeOne),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    width: 70,
                    height: 20,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: BlookStyle.quaternaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      "1-5",
                      style: BlookStyle.textCustom(
                          BlookStyle.whiteColor, BlookStyle.textSizeOne),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    width: 70,
                    height: 20,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: BlookStyle.quaternaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      "1-5",
                      style: BlookStyle.textCustom(
                          BlookStyle.whiteColor, BlookStyle.textSizeOne),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: BlookStyle.greyBoxColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 15.0,
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Capítulo 1",
                      style: BlookStyle.textCustom(
                          BlookStyle.whiteColor, BlookStyle.textSizeTwo),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: BlookStyle.whiteColor,
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: BlookStyle.greyBoxColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 15.0,
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Capítulo 2",
                      style: BlookStyle.textCustom(
                          BlookStyle.whiteColor, BlookStyle.textSizeTwo),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: BlookStyle.whiteColor,
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: BlookStyle.greyBoxColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 15.0,
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Capítulo 3",
                      style: BlookStyle.textCustom(
                          BlookStyle.whiteColor, BlookStyle.textSizeTwo),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: BlookStyle.whiteColor,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
