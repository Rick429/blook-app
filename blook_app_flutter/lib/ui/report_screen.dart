import 'package:blook_app_flutter/utils/styles.dart';
import 'package:flutter/material.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController commentController = TextEditingController();

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
              "REPORTAR",
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
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        "Marcar la opción a reportar",
                        style: BlookStyle.textCustom(
                            BlookStyle.whiteColor, BlookStyle.textSizeThree),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 4),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: BlookStyle.blackColor,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: BlookStyle.formColor, width: 2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          elevation: 15.0,
                        ),
                        onPressed: () {},
                        child: Text(
                          "No se carga el contenido",
                          style: BlookStyle.textCustom(
                              BlookStyle.formColor, BlookStyle.textSizeTwo),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 4),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: BlookStyle.blackColor,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: BlookStyle.formColor, width: 2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          elevation: 15.0,
                        ),
                        onPressed: () {},
                        child: Text(
                          "Capítulos incorrectos",
                          style: BlookStyle.textCustom(
                              BlookStyle.formColor, BlookStyle.textSizeTwo),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 4),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: BlookStyle.blackColor,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: BlookStyle.formColor, width: 2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          elevation: 15.0,
                        ),
                        onPressed: () {},
                        child: Text(
                          "Contenido inapropiado",
                          style: BlookStyle.textCustom(
                              BlookStyle.formColor, BlookStyle.textSizeTwo),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 4),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: BlookStyle.blackColor,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: BlookStyle.formColor, width: 2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          elevation: 15.0,
                        ),
                        onPressed: () {},
                        child: Text(
                          "Otros",
                          style: BlookStyle.textCustom(
                              BlookStyle.formColor, BlookStyle.textSizeTwo),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        "Envía tus comentarios",
                        style: BlookStyle.textCustom(
                            BlookStyle.whiteColor, BlookStyle.textSizeThree),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(8),
                      child: TextFormField(
                        style: BlookStyle.textCustom(
                            BlookStyle.whiteColor, BlookStyle.textSizeTwo),
                        controller: commentController,
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: BlookStyle.blackColor,
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: BlookStyle.formColor, width: 5.0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: BlookStyle.formColor,
                              width: 2.0,
                            ),
                          ),
                          hintMaxLines: 10,
                          hintStyle: BlookStyle.textCustom(
                              BlookStyle.formColor, BlookStyle.textSizeTwo),
                          hintText:
                              '¿Quieres agregar algo más? Escribelo \nRecuerda no incluir datos sensibles',
                        ),
                        onSaved: (String? value) {},
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.fromLTRB(10, 100, 10, 8),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: BlookStyle.primaryColor,
                          elevation: 15.0,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/');
                        },
                        child: Text("Enviar",
                            style: BlookStyle.textCustom(BlookStyle.whiteColor,
                                BlookStyle.textSizeThree))),
                  )
            ],
          ),
        ),
      ),
    );
  }
}
