import 'dart:convert';
import 'dart:io';

import 'package:blook_app_flutter/blocs/book_new_bloc/book_new_bloc.dart';
import 'package:blook_app_flutter/blocs/genres_bloc/genres_bloc.dart';
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
  late GenreRepository genreRepository;
  final ImagePicker _picker = ImagePicker();
  late List<Genre> lista;
  late GenresBloc _genresbloc;
  late List<Object?> _selectedgenres;

  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : <XFile>[value];
  }

  @override
  void initState() {
    bookRepository = BookRepositoryImpl();
    genreRepository = GenreRepositoryImpl();
    PreferenceUtils.init();
    PreferenceUtils.setString("cover", "");
    _genresbloc = GenresBloc(genreRepository)..add(const FetchAllGenres());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => BookNewBloc(bookRepository)),
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
                    "PUBLICAR",
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
                    physics: const NeverScrollableScrollPhysics(),
                    child: _createBody(context)))));
  }

  Widget _createBody(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(children: [
        BlocConsumer<BookNewBloc, BookNewState>(
            listenWhen: (context, state) {
              return state is CreateBookSuccessState;
            },
            listener: (context, state) {},
            buildWhen: (context, state) {
              return state is BookNewInitial || state is CreateBookSuccessState;
            },
            builder: (context, state) {
              if (state is CreateBookSuccessState) {
                PreferenceUtils.setString("idbook", state.book.id);
                return buildForm(context, state);
              }
              return buildForm(context, state);
            }),
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
      ]),
    );
  }

  Widget _genresList(context, List<Genre> genresList) {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.all(10),
            height: 150,
            child: MultiSelectDialogField(
              decoration: BoxDecoration(
                color: BlookStyle.greyBoxColor,
                borderRadius: BorderRadius.circular(20.0),
              ),
              title: const Text("Géneros"),
              items: genresList.map((e) => MultiSelectItem(e, utf8.decode(e.name.codeUnits))).toList(),
              listType: MultiSelectListType.CHIP,
              onConfirm: (values) {
                _selectedgenres = values;
              },
            )),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.fromLTRB(10, 10, 10, 8),
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

                  BlocProvider.of<BookNewBloc>(context).add(CreateBookEvent(
                      PreferenceUtils.getString("cover")!, createBookDto));
                  Navigator.pushNamed(context, '/chapternew');
                }
              },
              child: Text("Siguiente",
                  style: BlookStyle.textCustom(
                      BlookStyle.whiteColor, BlookStyle.textSizeThree))),
        )
      ],
    );
  }

  Widget coverUrl(String cover) {
    if(cover.isEmpty) {
      return GestureDetector(
                  onTap: () async {                
                    final XFile? pickedFile =
                        await _picker.pickImage(source: ImageSource.gallery);
                    setState(() {
                      PreferenceUtils.setString("cover", pickedFile!.path);
                    });
                  },
                  child: Image.asset("assets/images/upload.png", height: 200),
                );
    } else {
      return GestureDetector(
                  onTap: () async {                
                    final XFile? pickedFile =
                        await _picker.pickImage(source: ImageSource.gallery);
                    setState(() {
                      PreferenceUtils.setString("cover", pickedFile!.path);
                    });
                  },
                  child: Image.file(File(PreferenceUtils.getString("cover")!), height: 200,)
                );
    }
  }

  Widget buildForm(BuildContext context, state) {
    return SizedBox(
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                coverUrl(PreferenceUtils.getString("cover")??""),
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
    );
  }
}
