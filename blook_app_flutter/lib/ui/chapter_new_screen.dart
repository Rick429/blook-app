import 'package:blook_app_flutter/utils/styles.dart';
import 'package:flutter/material.dart';

class ChapterNewScreen extends StatefulWidget {
  const ChapterNewScreen({Key? key}) : super(key: key);

  @override
  State<ChapterNewScreen> createState() => _ChapterNewScreenState();
}

class _ChapterNewScreenState extends State<ChapterNewScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController fileController = TextEditingController();

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
              "AÑADIR CAPÍTULO",
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
          child: ListView(children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    height: 50,
                    margin: const EdgeInsets.all(10),
                    child: TextFormField(
                      style: BlookStyle.textCustom(
                          BlookStyle.whiteColor, BlookStyle.textSizeTwo),
                      controller: nameController,
                      textAlignVertical: TextAlignVertical.bottom,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: BlookStyle.greyBoxColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        hintStyle: BlookStyle.textCustom(
                            BlookStyle.formColor, BlookStyle.textSizeTwo),
                        hintText: 'Nombre del capítulo',
                      ),
                      onSaved: (String? value) {},
                      validator: (String? value) {
                        return (value == null)
                            ? 'Introduzca el nombre del capítulo'
                            : null;
                      },
                    ),
                  ),
                  Container(
                    height: 50,
                    margin: const EdgeInsets.all(10),
                    child: TextFormField(
                      style: BlookStyle.textCustom(
                          BlookStyle.whiteColor, BlookStyle.textSizeTwo),
                      controller: fileController,
                      textAlignVertical: TextAlignVertical.bottom,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: BlookStyle.greyBoxColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        hintStyle: BlookStyle.textCustom(
                            BlookStyle.formColor, BlookStyle.textSizeTwo),
                        hintText: 'Seleccionar archivos',
                      ),
                      onSaved: (String? value) {},
                      validator: (String? value) {
                        return (value == null) ? 'Seleccione un archivo' : null;
                      },
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.fromLTRB(10, 200, 10, 8),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: BlookStyle.primaryColor,
                          elevation: 15.0,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/');
                        },
                        child: Text("Publicar",
                            style: BlookStyle.textCustom(BlookStyle.whiteColor,
                                BlookStyle.textSizeThree))),
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
