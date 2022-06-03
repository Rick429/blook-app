import 'dart:convert';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:blook_app_flutter/blocs/edit_book_bloc/edit_book_bloc.dart';
import 'package:blook_app_flutter/blocs/genres_bloc/genres_bloc.dart';
import 'package:blook_app_flutter/models/book_response.dart';
import 'package:blook_app_flutter/models/create_book_dto.dart';
import 'package:blook_app_flutter/models/genre_response.dart';
import 'package:blook_app_flutter/repository/book_repository/book_repository.dart';
import 'package:blook_app_flutter/repository/book_repository/book_repository_impl.dart';
import 'package:blook_app_flutter/repository/genre_repository/genre_repository.dart';
import 'package:blook_app_flutter/repository/genre_repository/genre_repository_impl.dart';
import 'package:blook_app_flutter/ui/menu_screen.dart';
import 'package:blook_app_flutter/utils/preferences.dart';
import 'package:blook_app_flutter/utils/styles.dart';
import 'package:blook_app_flutter/widgets/error_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality);

class BookEditScreen extends StatefulWidget {
  final Book libroEditado;
  const BookEditScreen({Key? key, required this.libroEditado}) : super(key: key);

  @override
  State<BookEditScreen> createState() => _BookEditScreenState();
}

class _BookEditScreenState extends State<BookEditScreen> {
  List<XFile>? _imageFileList;
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController descriptionController;
  TextEditingController genreController = TextEditingController();
  late BookRepository bookRepository;
  late GenreRepository genreRepository;
  final ImagePicker _picker = ImagePicker();
  late GenresBloc _genresbloc;
  late List<Object?> _selectedgenres;

  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : <XFile>[value];
  }

  @override
  void initState() {
    nameController =
        TextEditingController(text: utf8.decode(widget.libroEditado.name.codeUnits));
    descriptionController = TextEditingController(
        text: utf8.decode(widget.libroEditado.description.codeUnits));
    bookRepository = BookRepositoryImpl();
    genreRepository = GenreRepositoryImpl();
    PreferenceUtils.init();
    PreferenceUtils.setString("coveredit", "");
    _genresbloc = GenresBloc(genreRepository)..add(const FetchAllGenres());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => EditBookBloc(bookRepository)),
          BlocProvider(create: (context) => _genresbloc)
        ],
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              iconTheme: const IconThemeData(color: Colors.white),
              title: Center(
                child: Container(
                  margin: const EdgeInsets.only(right: 60),
                  child: Text(
                    "EDITAR",
                    style: BlookStyle.textCustom(
                        BlookStyle.whiteColor, BlookStyle.textSizeFive),
                  ),
                ),
              ),
            ),
            backgroundColor: BlookStyle.blackColor,
            body: RefreshIndicator(
                onRefresh: () async {},
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    child: _createBody(context)))));
  }

  Widget _createBody(BuildContext context) {
    return Column(children: [
      BlocBuilder<GenresBloc, GenresState>(
        bloc: _genresbloc,
        builder: (context, state) {
          if (state is GenresInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GenresFetchError) {
            return ErrorPage(
              message: state.message,
              retry: () {
                context.watch<GenresBloc>().add(const FetchAllGenres());
              },
            );
          } else if (state is GenresFetched) {
            return _genresList(context, state.genres);
          } else {
            return const Text('Not support');
          }
        },
      ),
      BlocConsumer<EditBookBloc, EditBookState>(
          listenWhen: (context, state) {
            return state is EditBookSuccessState || state is EditBookErrorState;
          },
           listener: (context, state) {
            if (state is EditBookSuccessState) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MenuScreen()),
                
              );
              _createDialog(context);
            } else if (state is EditBookErrorState) {
              _showSnackbar(context, state.message);
            }
          },
          buildWhen: (context, state) {
            return state is EditBookInitial || state is EditBookSuccessState;
          },
          builder: (context, state) {
            if (state is EditBookSuccessState) {
              return Container();
            }
            return Container();
          }),
    ]);
  }

  AwesomeDialog _createDialog(context) {
    return AwesomeDialog(
      context: context,
      dialogBackgroundColor: BlookStyle.quaternaryColor,
      btnOkColor: BlookStyle.primaryColor,
      dialogType: DialogType.SUCCES,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Correcto',
      desc: 'El libro se ha editado correctamente',
      titleTextStyle:
          BlookStyle.textCustom(BlookStyle.whiteColor, BlookStyle.textSizeFour),
      descTextStyle: BlookStyle.textCustom(
          BlookStyle.whiteColor, BlookStyle.textSizeThree),
      btnOkText: "Aceptar",
      btnOkOnPress: () {},
    )..show();
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _genresList(context, List<Genre> genresList) {
    List<Genre> genresLists = [];
    for (Genre e in widget.libroEditado.genres) {
      for (Genre e2 in genresList) {
        if (e.id == e2.id) {
          genresLists.add(e2);
        }
      }
    }
    _selectedgenres = genresLists;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          SizedBox(
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      coverUrl(widget.libroEditado.cover),
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
                          maxLines: 4,
                          minLines: 4,
                          onSaved: (String? value) {},
                          validator: (String? value) {
                            return (value == null)
                                ? 'Introduzca la descripción del libro'
                                : null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
              margin: const EdgeInsets.all(10),
              height: 150,
              child: MultiSelectDialogField(
                decoration: BoxDecoration(
                  color: BlookStyle.greyBoxColor,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                title: const Text("Géneros"),
                items: genresList
                    .map((e) =>
                        MultiSelectItem(e, utf8.decode(e.name.codeUnits)))
                    .toList(),
                listType: MultiSelectListType.CHIP,
                initialValue: genresLists,
                onConfirm: (values) {
                  _selectedgenres = values;
                },
              )),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: BlookStyle.primaryColor,
                  elevation: 15.0,
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final createBookDto = CreateBookDto(
                        name: nameController.text,
                        description: descriptionController.text,
                        generos: _selectedgenres);

                    BlocProvider.of<EditBookBloc>(context).add(EditOneBookEvent(
                        PreferenceUtils.getString("coveredit")!,
                        createBookDto,
                        widget.libroEditado.id));
                    PreferenceUtils.setString("idbook", widget.libroEditado.id);
                  }
                },
                child: Text("Guardar",
                    style: BlookStyle.textCustom(
                        BlookStyle.whiteColor, BlookStyle.textSizeThree))),
          )
        ],
      ),
    );
  }

  Widget coverUrl(String cover) {
    if (PreferenceUtils.getString("coveredit") == "") {
      return GestureDetector(
        onTap: () async {
          final XFile? pickedFile =
              await _picker.pickImage(source: ImageSource.gallery);
          setState(() {
            PreferenceUtils.setString("coveredit", pickedFile!.path);
          });
        },
        child: Image.network(
          cover,
          headers: {
            'Authorization': 'Bearer ${PreferenceUtils.getString('token')}'
          },
          height: 200,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return GestureDetector(
          onTap: () async {
            final XFile? pickedFile =
                await _picker.pickImage(source: ImageSource.gallery);
            setState(() {
              PreferenceUtils.setString("coveredit", pickedFile!.path);
            });
          },
          child: Image.file(
            File(PreferenceUtils.getString("coveredit")!),
            height: 200,
          ));
    }
  }
}
