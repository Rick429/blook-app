import 'dart:convert';
import 'package:blook_app_flutter/blocs/my_books_bloc/my_books_bloc.dart';
import 'package:blook_app_flutter/models/book_response.dart';
import 'package:blook_app_flutter/repository/book_repository/book_repository.dart';
import 'package:blook_app_flutter/repository/book_repository/book_repository_impl.dart';
import 'package:blook_app_flutter/utils/preferences.dart';
import 'package:blook_app_flutter/utils/styles.dart';
import 'package:blook_app_flutter/widgets/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

import '../blocs/all_books_bloc/all_books_bloc.dart';

class BooksScreen extends StatefulWidget {
  const BooksScreen({Key? key}) : super(key: key);

  @override
  _BooksScreenState createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  late BookRepository bookRepository;
  late AllBooksBloc _allbooksbloc;
  late String title = "";
  late String sortopt = "name,desc";
  final box = GetStorage();

  @override
  void initState() {
    box.write("s", sortopt);
    bookRepository = BookRepositoryImpl();
    _allbooksbloc = AllBooksBloc(bookRepository)
      ..add(FetchAllBooks(10, box.read("s")!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [BlocProvider(create: (context) => _allbooksbloc)],
        child: Scaffold(
            backgroundColor: BlookStyle.blackColor,
            appBar: const HomeAppBar(),
            body: RefreshIndicator(
                onRefresh: () async {},
                child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: _createBody(context)))));
  }

  Widget _createBody(BuildContext context) {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: BlocBuilder<AllBooksBloc, AllBooksState>(
          bloc: _allbooksbloc,
          builder: (context, state) {
            if (state is AllBooksInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AllBooksFetchError) {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Center(
                      child: Text("BIBLIOTECA",
                          style: BlookStyle.textCustom(
                              BlookStyle.whiteColor, BlookStyle.textSizeFive)),
                    ),
                    Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: BlookStyle.quaternaryColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              "Ordenado por:",
                              style: BlookStyle.textCustom(
                                  BlookStyle.whiteColor,
                                  BlookStyle.textSizeTwo),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(10),
                            child: Icon(
                              Icons.filter_list,
                              color: BlookStyle.whiteColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is AllBooksFetched) {
              return _booksList(context, state.allbooks, state.pagesize);
            } else {
              return const Text('Error al cargar la lista');
            }
          },
        ),
      ),
    );
  }

  Widget _booksList(context, List<Book> allbooks, int pagesize) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Center(
            child: Text("BIBLIOTECA",
                style: BlookStyle.textCustom(
                    BlookStyle.whiteColor, BlookStyle.textSizeFive)),
          ),
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: BlookStyle.quaternaryColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "Ordenado por: $title",
                    style: BlookStyle.textCustom(
                        BlookStyle.whiteColor, BlookStyle.textSizeTwo),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: IconButton(
                    onPressed: () {
                      showModal(context, allbooks);
                    },
                    icon: const Icon(
                      Icons.filter_list,
                      color: BlookStyle.whiteColor,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 200),
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: allbooks.length,
               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: (0.78) ),
              itemBuilder: (context, index) {
                
                if (sortopt != "") {
                  context
                      .watch<AllBooksBloc>()
                      .add(FetchAllBooks(10, sortopt));
                  sortopt = "";
                }
                if (index == allbooks.length - 1 && allbooks.length < pagesize) {
                  context
                      .watch<MyBooksBloc>()
                      .add(FetchAllMyBooks(index + 10, sortopt));
                }
                
                return Center(child: _bookItem(allbooks.elementAt(index)));
              }
            ),
          ),
        ],
      ),
    );
  }

  Widget _bookItem(Book book) {
    return
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
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          book.cover,
                          /* headers: {
                            'Authorization':
                                'Bearer ${PreferenceUtils.getString('token')}'
                          }, */
                          width: MediaQuery.of(context).size.width/2,
                          height: MediaQuery.of(context).size.width/2.5,
                          fit: BoxFit.cover,
                        )),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width/8,
                    width:  MediaQuery.of(context).size.width/2.6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          utf8.decode(book.name.codeUnits),
                          style: BlookStyle.textCustom(
                              BlookStyle.whiteColor, BlookStyle.textSizeTwo),
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
      
  
    );
  }

  showModal(BuildContext context, List<Book> books) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            decoration: const BoxDecoration(color: BlookStyle.quaternaryColor),
            height: 200,
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 150,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: BlookStyle.primaryColor,
                            elevation: 15.0,
                          ),
                          onPressed: () {
                            setState(() {
                              title = "más reciente";
                              sortopt = "releaseDate,desc";
                              box.write("s", sortopt);

                              Navigator.pop(context);
                            });
                          },
                          child: Text("Más reciente",
                              style: BlookStyle.textCustom(
                                  BlookStyle.whiteColor,
                                  BlookStyle.textSizeThree)),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: BlookStyle.primaryColor,
                            elevation: 15.0,
                          ),
                          onPressed: () {
                            setState(() {
                              title = "más antiguo";
                              sortopt = "releaseDate,asc";
                              box.write("s", sortopt);
                              books.sort((a, b) =>
                                  a.releaseDate.compareTo(b.releaseDate));
                              Navigator.pop(context);
                            });
                          },
                          child: Text("Más antiguo",
                              style: BlookStyle.textCustom(
                                  BlookStyle.whiteColor,
                                  BlookStyle.textSizeThree)),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 150,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: BlookStyle.primaryColor,
                            elevation: 15.0,
                          ),
                          onPressed: () {
                            setState(() {
                              title = "nombre de A-Z";
                              sortopt = "name,desc";
                              box.write("s", sortopt);
                              books.sort((a, b) => b.name.compareTo(a.name));
                              Navigator.pop(context);
                            });
                          },
                          child: Text("Ordenar de A-Z",
                              style: BlookStyle.textCustom(
                                  BlookStyle.whiteColor,
                                  BlookStyle.textSizeThree)),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: BlookStyle.primaryColor,
                            elevation: 15.0,
                          ),
                          onPressed: () {
                            setState(() {
                              title = "nombre de Z-A";
                              sortopt = "name,asc";
                              box.write("s", sortopt);
                              Navigator.pop(context);
                            });
                          },
                          child: Text("Ordenar de Z-A",
                              style: BlookStyle.textCustom(
                                  BlookStyle.whiteColor,
                                  BlookStyle.textSizeThree)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
