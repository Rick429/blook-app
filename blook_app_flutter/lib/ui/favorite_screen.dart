import 'dart:convert';
import 'package:blook_app_flutter/blocs/my_favorite_books/my_favorite_books_bloc.dart';
import 'package:blook_app_flutter/models/book_response.dart';
import 'package:blook_app_flutter/repository/book_repository/book_repository.dart';
import 'package:blook_app_flutter/repository/book_repository/book_repository_impl.dart';
import 'package:blook_app_flutter/utils/preferences.dart';
import 'package:blook_app_flutter/utils/styles.dart';
import 'package:blook_app_flutter/widgets/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late BookRepository bookRepository;
  late MyFavoriteBooksBloc _myfavoritebooksbloc;
  late String title = "";

  @override
  void initState() {
    PreferenceUtils.init();
    bookRepository = BookRepositoryImpl();
     _myfavoritebooksbloc = MyFavoriteBooksBloc(bookRepository)..add(const FetchAllMyFavoriteBooks(10));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => _myfavoritebooksbloc)
        ],
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
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: BlocBuilder<MyFavoriteBooksBloc, MyFavoriteBooksState>(
            bloc: _myfavoritebooksbloc,
            builder: (context, state) {
              if (state is MyFavoriteBooksInitial) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is MyFavoriteBooksFetchError) {
                return Column(children: [
                     Center(
                child: Text("FAVORITOS",
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
                          "Ordenado por: nombre",
                          style: BlookStyle.textCustom(
                              BlookStyle.whiteColor, BlookStyle.textSizeTwo),
                        ),
                      ),
                       Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.filter_list, color: BlookStyle.whiteColor,)),
                      )
                    ],
                  ),
                ),
                ],);
              } else if (state is MyFavoriteBooksFetched) {
                return _booksList(context, state.mybooks, state.pagesize);
              } else {
                return const Text('Not support');
              }
            },
      ),
    );
  }
 
  Widget _booksList(context, List<Book> myfavoritebooks, int pagesize) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
              children: [
                Center(
                  child: Text("FAVORITOS",
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
                    padding: const EdgeInsets.symmetric(horizontal: 10),
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
                        showModal(context, myfavoritebooks);
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
              child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
                itemCount: myfavoritebooks.length,
                itemBuilder: (context, index) {
                if(index==myfavoritebooks.length-1&&myfavoritebooks.length<pagesize){
                    context.watch<MyFavoriteBooksBloc>().add(FetchAllMyFavoriteBooks(index+10));
                  }
                return _bookItem(myfavoritebooks.elementAt(index));
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
                            book.cover/* ,
                        headers: {
                          'Authorization':
                              'Bearer ${PreferenceUtils.getString('token')}'} */,
                            width: 130,
                            height: 200,
                            fit: BoxFit.cover,
                          )),
                    ),
                    SizedBox(
                      height: 190,
                      width: 200,
                      child: Text(
                        utf8.decode(book.name.codeUnits),
                        style: BlookStyle.textCustom(
                            BlookStyle.whiteColor, BlookStyle.textSizeTwo),
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ),
       ),
    ],);
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
