import 'package:blook_app_flutter/blocs/search_bloc/search_bloc.dart';
import 'package:blook_app_flutter/models/book_response.dart';
import 'package:blook_app_flutter/models/search_dto.dart';
import 'package:blook_app_flutter/repository/book_repository/book_repository.dart';
import 'package:blook_app_flutter/repository/book_repository/book_repository_impl.dart';
import 'package:blook_app_flutter/utils/preferences.dart';
import 'package:blook_app_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final box = GetStorage();
  late BookRepository bookRepository;
  final _formKey = GlobalKey<FormState>();
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    bookRepository = BookRepositoryImpl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Container(
            margin: const EdgeInsets.only(right: 60),
            child: Text(
              "BUSCADOR",
              style: BlookStyle.textCustom(
                  BlookStyle.whiteColor, BlookStyle.textSizeFive),
            ),
          ),
        ),
        backgroundColor: BlookStyle.blackColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: BlookStyle.blackColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          child: BlocProvider(
              create: (context) {
                return SearchBloc(bookRepository);
              },
              child: _createBody(context)),
        ),
      ),
    );
  }

  Widget _createBody(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchInitial) {
          return buildForm(context);
        } else if (state is SearchErrorState) {
          return buildForm(context);
        } else if (state is SearchSuccessState) {
          return Column(
            children: [buildForm(context), _buildList(context, state.books)],
          );
        } else {
          return const Text('Not support');
        }
      },
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Row(
        children: [
          Container(
            width: 340,
            height: 50,
            margin: const EdgeInsets.all(10),
            child: TextFormField(
              style: BlookStyle.textCustom(
                  BlookStyle.blackColor, BlookStyle.textSizeTwo),
              controller: searchController,
              textAlignVertical: TextAlignVertical.bottom,
              decoration: InputDecoration(
                filled: true,
                fillColor: BlookStyle.whiteColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                hintStyle: BlookStyle.textCustom(
                    BlookStyle.blackColor, BlookStyle.textSizeTwo),
                hintText: 'Buscar...',
              ),
              onSaved: (String? value) {},
              validator: (String? value) {
                return (value == null)
                    ? 'Introduzca el nombre del libro'
                    : null;
              },
            ),
          ),
          GestureDetector(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  final searchDto = SearchDto(name: searchController.text);
                  BlocProvider.of<SearchBloc>(context)
                      .add(DoSearchEvent(searchDto));
                }
              },
              child: const Icon(
                Icons.search,
                color: BlookStyle.primaryColor,
              ))
        ],
      ),
    );
  }

  Widget _buildList(context, List<Book> booklist) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      height: 600,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: booklist.length,
        itemBuilder: (context, index) {
          return _bookItem(booklist.elementAt(index));
        },
      ),
    );
  }

  Widget _bookItem(Book book) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            box.write("idbook", book.id);
            Navigator.pushNamed(context, "/book");
          },
          child: Container(
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
                      child: Image.network(
                        book.cover,
                        /* headers: {
                          'Authorization':
                              'Bearer ${PreferenceUtils.getString('token')}'}, */
                        width: 130,
                        height: 200,
                        fit: BoxFit.cover,
                      )),
                ),
                SizedBox(
                  height: 140,
                  child: Text(
                    book.name,
                    style: BlookStyle.textCustom(
                        BlookStyle.whiteColor, BlookStyle.textSizeTwo),
                    textAlign: TextAlign.start,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
