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

class MyBooksScreen extends StatefulWidget {
  const MyBooksScreen({Key? key}) : super(key: key);

  @override
  _MyBooksScreenState createState() => _MyBooksScreenState();
}

class _MyBooksScreenState extends State<MyBooksScreen> {
  late BookRepository bookRepository;
  late MyBooksBloc _mybooksbloc;
  late String title = "";

  @override
  void initState() {
    PreferenceUtils.init();
    bookRepository = BookRepositoryImpl();
    _mybooksbloc = MyBooksBloc(bookRepository)..add(const FetchAllMyBooks(10));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [BlocProvider(create: (context) => _mybooksbloc)],
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
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: BlocBuilder<MyBooksBloc, MyBooksState>(
        bloc: _mybooksbloc,
        builder: (context, state) {
          if (state is MyBooksInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MyBooksFetchError) {
            return Column(
              children: [
                Center(
                  child: Text("MIS LIBROS",
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
                              BlookStyle.whiteColor, BlookStyle.textSizeTwo),
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
            );
          } else if (state is MyBooksFetched) {
            return _booksList(context, state.mybooks, state.pagesize);
          } else {
            return const Text('Not support');
          }
        },
      ),
    );
  }

  Widget _booksList(context, List<Book> mybooks, int pagesize) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Center(
            child: Text("MIS LIBROS",
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
                  padding: EdgeInsets.all(10),
                  child: IconButton(
                    onPressed: () {
                      showModal(context, mybooks);
                    },
                    icon: Icon(
                      Icons.filter_list,
                      color: BlookStyle.whiteColor,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 100),
            height: 500,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: mybooks.length,
              itemBuilder: (context, index) {
                print(index);
                print("size $pagesize");
                if(index==mybooks.length-1&&mybooks.length<pagesize){
                  context.watch<MyBooksBloc>().add(FetchAllMyBooks(index+10));
                }
                return _bookItem(mybooks.elementAt(index));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _bookItem(Book book) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            PreferenceUtils.setString("idbook", book.id);
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
                        headers: {
                          'Authorization':
                              'Bearer ${PreferenceUtils.getString('token')}'
                        },
                        width: 130,
                        height: 200,
                        fit: BoxFit.cover,
                      )),
                ),
                SizedBox(
                  height: 190,
                  width: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        utf8.decode(book.name.codeUnits),
                        style: BlookStyle.textCustom(
                            BlookStyle.whiteColor, BlookStyle.textSizeTwo),
                        textAlign: TextAlign.start,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.remove_red_eye,
                                  color: BlookStyle.whiteColor,
                                ),
                                Text(
                                  "3700",
                                  style: BlookStyle.textCustom(
                                      BlookStyle.whiteColor,
                                      BlookStyle.textSizeTwo),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, "/comments");
                              },
                              child: Column(
                                children: [
                                  const Icon(Icons.comment,
                                      color: BlookStyle.whiteColor),
                                  Text(
                                    '${book.comments.length}',
                                    style: BlookStyle.textCustom(
                                        BlookStyle.whiteColor,
                                        BlookStyle.textSizeTwo),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  showModal(BuildContext context, List<Book> books) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(color: BlookStyle.quaternaryColor),
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
                          title="más reciente";
                          books.sort((a, b) => b.releaseDate.compareTo(a.releaseDate));
                          Navigator.pop(context);
                        });
                      },
                      child: Text("Más reciente",
                          style: BlookStyle.textCustom(
                              BlookStyle.whiteColor, BlookStyle.textSizeThree)),
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
                          title="más antiguo";
                          books.sort((a, b) => a.releaseDate.compareTo(b.releaseDate));
                          Navigator.pop(context);
                        });
                      },
                      child: Text("Más antiguo",
                          style: BlookStyle.textCustom(
                              BlookStyle.whiteColor, BlookStyle.textSizeThree)),
                    ),
                  )
                  ],),
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
                              books.sort((a, b) => b.name.compareTo(a.name));
                              title="nombre de A-Z";
                              Navigator.pop(context);
                            });
                          },
                          child: Text("Ordenar de A-Z",
                              style: BlookStyle.textCustom(
                                  BlookStyle.whiteColor, BlookStyle.textSizeThree)),
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
                              title="nombre de Z-A";
                              books.sort((a, b) => a.name.compareTo(b.name));
                              Navigator.pop(context);
                            });
                          },
                          child: Text("Ordenar de Z-A",
                              style: BlookStyle.textCustom(
                                  BlookStyle.whiteColor, BlookStyle.textSizeThree)),
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
