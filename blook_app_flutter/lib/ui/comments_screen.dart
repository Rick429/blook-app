import 'package:blook_app_flutter/utils/styles.dart';
import 'package:flutter/material.dart';

class CommentsScren extends StatefulWidget {
  const CommentsScren({Key? key}) : super(key: key);

  @override
  State<CommentsScren> createState() => _CommentsScrenState();
}

class _CommentsScrenState extends State<CommentsScren> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Center(
          child: Container(
            margin: const EdgeInsets.only(right: 60),
            child: Text(
              "COMENTARIOS",
              style: BlookStyle.textCustom(
                  BlookStyle.whiteColor, BlookStyle.textSizeFive),
            ),
          ),
        ),
      ),
      backgroundColor: BlookStyle.blackColor,
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: BlookStyle.greyBoxColor),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                                'assets/images/portada.jpg',
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                "username",
                                style: BlookStyle.textCustom(
                                    BlookStyle.whiteColor,
                                    BlookStyle.textSizeOne),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/2.5),
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                "04/08/2022",
                                style: BlookStyle.textCustom(
                                    BlookStyle.whiteColor,
                                    BlookStyle.textSizeOne),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 8.0),
                        width: MediaQuery.of(context).size.width,
                        child: Text("Muy buen libro",
                                  style: BlookStyle.textCustom(
                                      BlookStyle.whiteColor,
                                      BlookStyle.textSizeOne),textAlign: TextAlign.left,),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/report');
                              },
                              child: const Icon(Icons.report_problem_rounded, color: BlookStyle.whiteColor)),
                          ],
                        ),),
                      
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
