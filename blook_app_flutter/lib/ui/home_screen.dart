import 'package:blook_app_flutter/blocs/books_bloc/books_bloc.dart';
import 'package:blook_app_flutter/models/book_response.dart';
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
      ..add(FetchBooksWithType("new/"));
    _orderBooksBloc = BooksBloc(bookRepository)
      ..add(FetchBooksWithType("order/"));
    super.initState();
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
      Stack(
        children: [
          Image.asset(
            "assets/images/portada.jpg",
            height: 350,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 230),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "HARRY POTTER",
                  style: BlookStyle.textCustom(
                      BlookStyle.whiteColor, BlookStyle.textSizeSix),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 300),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    margin: const EdgeInsets.all(4),
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        border: Border.all(color: BlookStyle.whiteColor),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      "Fantasia",
                      style: BlookStyle.textCustom(
                          BlookStyle.whiteColor, BlookStyle.textSizeThree),
                    )),
                Container(
                    margin: const EdgeInsets.all(4),
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        border: Border.all(color: BlookStyle.whiteColor),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      "Fantasia",
                      style: BlookStyle.textCustom(
                          BlookStyle.whiteColor, BlookStyle.textSizeThree),
                    )),
                Container(
                    margin: const EdgeInsets.all(4),
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        border: Border.all(color: BlookStyle.whiteColor),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      "Fantasia",
                      style: BlookStyle.textCustom(
                          BlookStyle.whiteColor, BlookStyle.textSizeThree),
                    )),
              ],
            ),
          )
        ],
      ),
      Row(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            width: 130,
            child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Leer",
                  style: BlookStyle.textCustom(
                      BlookStyle.whiteColor, BlookStyle.textSizeFour),
                )),
          ),
          const Icon(
            Icons.favorite,
            color: BlookStyle.whiteColor,
          )
        ],
      ),
      BlocBuilder<BooksBloc, BooksState>(
        bloc: _topNewBooksBloc,
        builder: (context, state) {
          if (state is BooksInitial) {
            return const CircularProgressIndicator();
          } else if (state is BooksFetchError) {
            return ErrorPage(
              message: state.message,
              retry: () {
                context.watch<BooksBloc>().add(FetchBooksWithType("new/"));
              },
            );
          } else if (state is BooksFetched) {
            return _createBookView(
                "Añadidos Recientemente", context, state.books);
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
                    headers: {
                      'Authorization':
                          'Bearer ${PreferenceUtils.getString('token')}'
                    },
                    width: 130,
                    height: 200,
                    fit: BoxFit.cover,
                  )),
            ),
            Text(book.name,
                style: BlookStyle.textCustom(
                    BlookStyle.whiteColor, BlookStyle.textSizeTwo))
          ],
        ),
      ),
    );
  }
}
