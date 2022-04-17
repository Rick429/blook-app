import 'dart:io';

import 'package:blook_app_flutter/blocs/book_new_bloc/book_new_bloc.dart';
import 'package:blook_app_flutter/models/create_book_dto.dart';
import 'package:blook_app_flutter/repository/book_repository/book_repository.dart';
import 'package:blook_app_flutter/repository/book_repository/book_repository_impl.dart';
import 'package:blook_app_flutter/utils/preferences.dart';
import 'package:blook_app_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality);

class BookNewScreen extends StatefulWidget {
  const BookNewScreen({Key? key}) : super(key: key);

  @override
  State<BookNewScreen> createState() => _BookNewScreenState();
}

class _BookNewScreenState extends State<BookNewScreen> {
  List<XFile>? _imageFileList;
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController genreController = TextEditingController();
  late BookRepository bookRepository;
  final ImagePicker _picker = ImagePicker();
  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : <XFile>[value];
  }

  @override
  void initState() {
    bookRepository = BookRepositoryImpl();
    PreferenceUtils.init();
    super.initState();
  }

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
      body: BlocProvider(
        create: (context) {
          return BookNewBloc(bookRepository);
        },
        child: BlocConsumer<BookNewBloc, BookNewState>(
            listenWhen: (context, state) {
              return state is CreateBookSuccessState;
            },
            listener: (context, state) {},
            buildWhen: (context, state) {
              return state is BookNewInitial || state is CreateBookSuccessState;
            },
            builder: (context, state) {
              if (state is CreateBookSuccessState) {
                return buildForm(context, state);
              }
              return buildForm(context, state);
            }),
      ),
    );
  }

  Widget buildForm(BuildContext context, state) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final XFile? pickedFile = await _picker.pickImage(
                            source: ImageSource.gallery);
                            setState(() {
                              PreferenceUtils.setString("cover", pickedFile!.path);
                            });
                        
                      },
                      child: Image.file(File(PreferenceUtils.getString("cover")??""), height: 200,),
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
                      if (_formKey.currentState!.validate()) {
                        final createBookDto = CreateBookDto(
                            name: nameController.text,
                            description: descriptionController.text);

                        BlocProvider.of<BookNewBloc>(context).add(
                            CreateBookEvent(PreferenceUtils.getString("cover")!,
                                createBookDto));
                        Navigator.pushNamed(context, '/chapternew');
                      }
                    },
                    child: Text("Siguiente",
                        style: BlookStyle.textCustom(
                            BlookStyle.whiteColor, BlookStyle.textSizeThree))),
              )
            ],
          ),
        
      ),
    );
  }
}
