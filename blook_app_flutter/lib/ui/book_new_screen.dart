import 'package:blook_app_flutter/utils/styles.dart';
import 'package:flutter/material.dart';

class BookNewScreen extends StatefulWidget {
  const BookNewScreen({Key? key}) : super(key: key);

  @override
  State<BookNewScreen> createState() => _BookNewScreenState();
}

class _BookNewScreenState extends State<BookNewScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController genreController = TextEditingController();

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
              "PUBLICAR",
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
                      margin: const EdgeInsets.all(10),
                      height: 200,
                      decoration: BoxDecoration(
                          color: BlookStyle.greyBoxColor,
                          borderRadius: BorderRadius.circular(20)),
                    ),
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
                          hintText: 'Nombre del libro',
                        ),
                        onSaved: (String? value) {},
                        validator: (String? value) {
                          return (value == null)
                              ? 'Introduzca el nombre del libro'
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
                        controller: descriptionController,
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: BlookStyle.greyBoxColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          hintStyle: BlookStyle.textCustom(
                              BlookStyle.formColor, BlookStyle.textSizeTwo),
                          hintText: 'Descripción del libro',
                        ),
                        onSaved: (String? value) {},
                        validator: (String? value) {
                          return (value == null)
                              ? 'Introduzca la descripción del libro'
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
                        controller: descriptionController,
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: BlookStyle.greyBoxColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          hintStyle: BlookStyle.textCustom(
                              BlookStyle.formColor, BlookStyle.textSizeTwo),
                          hintText: 'Géneros',
                        ),
                        onSaved: (String? value) {},
                        validator: (String? value) {
                          return (value == null)
                              ? 'Seleccione los géneros del libro'
                              : null;
                        },
                      ),
                    )
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
                      Navigator.pushNamed(context, '/chapternew');
                    },
                    child: Text("Siguiente",
                        style: BlookStyle.textCustom(
                            BlookStyle.whiteColor, BlookStyle.textSizeThree))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
