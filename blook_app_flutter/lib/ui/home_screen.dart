import 'dart:convert';
import 'package:blook_app_flutter/blocs/books_bloc/books_bloc.dart';
import 'package:blook_app_flutter/models/book_response.dart';
import 'package:blook_app_flutter/models/genre_response.dart';
import 'package:blook_app_flutter/repository/book_repository/book_repository.dart';
import 'package:blook_app_flutter/repository/book_repository/book_repository_impl.dart';
import 'package:blook_app_flutter/utils/preferences.dart';
import 'package:blook_app_flutter/utils/styles.dart';
import 'package:blook_app_flutter/widgets/error_page.dart';
import 'package:blook_app_flutter/widgets/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late BookRepository bookRepository;
  late BooksBloc _topNewBooksBloc;
  late BooksBloc _orderBooksBloc;

  @override
  void initState() {
    bookRepository = BookRepositoryImpl();
    PreferenceUtils.init();
    _topNewBooksBloc = BooksBloc(bookRepository)
      ..add(const FetchBooksWithType("new/"));
    _orderBooksBloc = BooksBloc(bookRepository)
      ..add(const FetchBooksWithType("order/"));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => _topNewBooksBloc),
          BlocProvider(create: (context) => _orderBooksBloc)
        ],
        child: Scaffold(
            backgroundColor: BlookStyle.blackColor,
            appBar: const HomeAppBar(),
            body: RefreshIndicator(
                onRefresh: () async {
                  _topNewBooksBloc.add(FetchBooksWithType("new/"));
                  _orderBooksBloc.add(FetchBooksWithType("order/"));
                },
                child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: _createBody(context)))));
  }

  Widget _createBody(BuildContext context) {
    return Column(children: [
      BlocBuilder<BooksBloc, BooksState>(
        bloc: _topNewBooksBloc,
        builder: (context, state) {
          if (state is BooksInitial) {
            return const CircularProgressIndicator();
          } else if (state is BooksFetchError) {
            return ErrorPage(
              message: state.message,
              retry: () {
                context
                    .watch<BooksBloc>()
                    .add(const FetchBooksWithType("new/"));
              },
            );
          } else if (state is BooksFetched) {
            return Column(
              children: [
                principalBook(state.books.first),
                _createBookView("Añadidos Recientemente", context, state.books),
              ],
            );
          } else {
            return const Text('Not support');
          }
        },
      ),
      BlocBuilder<BooksBloc, BooksState>(
        bloc: _orderBooksBloc,
        builder: (context, state) {
          if (state is BooksInitial) {
            return const CircularProgressIndicator();
          } else if (state is BooksFetchError) {
            return ErrorPage(
              message: state.message,
              retry: () {
                context.watch<BooksBloc>().add(FetchBooksWithType("order/"));
              },
            );
          } else if (state is BooksFetched) {
            return _createBookView("De la A - Z", context, state.books);
          } else {
            return const Text('Not support');
          }
        },
      ),
    ]);
  }

  Widget principalBook(Book book) {
    var lista;
    return Column(
      children: [
        Stack(
          children: [
            Image.network(
              book.cover,
          /*     headers: {
                'Authorization': 'Bearer ${PreferenceUtils.getString('token')}'
              }, */
              height: 350,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(top: 160),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      utf8.decode(book.name.codeUnits),
                      style: BlookStyle.textPrincipal,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 40,
              margin: const EdgeInsets.only(top: 300),
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: book.genres.length,
                itemBuilder: (context, index) {
                  lista = book.genres;
                  return oneGenre(context, lista.elementAt(index));
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              width: 130,
              child: ElevatedButton(
                onPressed: () {
                  PreferenceUtils.setString("idbook", book.id);
                  Navigator.pushNamed(context, "/book");
                },
                child: Text(
                  "Leer",
                  style: BlookStyle.textCustom(
                      BlookStyle.whiteColor, BlookStyle.textSizeFour),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget oneGenre(context, Genre genre) {
    return Container(
        width: 80,
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.only(top: 6),
        decoration: BoxDecoration(
            border: Border.all(color: BlookStyle.whiteColor),
            borderRadius: BorderRadius.circular(5)),
        child: Text(
          utf8.decode(genre.name.codeUnits),
          style: BlookStyle.textCustom(
              BlookStyle.whiteColor, BlookStyle.textSizeThree),
          textAlign: TextAlign.center,
        ));
  }

  Widget _createBookView(
      String titulo, BuildContext context, List<Book> books) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(titulo,
                style: BlookStyle.textCustom(
                    BlookStyle.whiteColor, BlookStyle.textSizeFour)),
          ),
        ],
      ),
      Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        width: MediaQuery.of(context).size.width,
        height: 260,
        child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return _bookItem(context, books[index]);
          },
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) => const VerticalDivider(
            color: Colors.transparent,
            width: 6.0,
          ),
          itemCount: books.length,
        ),
      ),
    ]);
  }

  Widget _bookItem(BuildContext context, Book book) {
    return GestureDetector(
      onTap: () {
        PreferenceUtils.setString("idbook", book.id);
        Navigator.pushNamed(context, "/book");
      },
      child: SizedBox(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    book.cover,
                    /* headers: {
                      'Authorization':
                          'Bearer ${PreferenceUtils.getString('token')}'
                    }, */
                    width: 130,
                    height: 200,
                    fit: BoxFit.cover,
                  )),
            ),
            SizedBox(
              width: 130,
              child: Text(utf8.decode(book.name.codeUnits),
                  overflow: TextOverflow.ellipsis,
                  style: BlookStyle.textCustom(
                      BlookStyle.whiteColor, BlookStyle.textSizeTwo)),
            )
          ],
        ),
      ),
    );
  }
}
