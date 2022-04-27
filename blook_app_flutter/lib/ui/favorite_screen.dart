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
     _myfavoritebooksbloc = MyFavoriteBooksBloc(bookRepository)..add(const FetchAllMyFavoriteBooks());
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
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child:  BlocBuilder<MyFavoriteBooksBloc, MyFavoriteBooksState>(
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
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(Icons.filter_list, color: BlookStyle.whiteColor,),
                    )
                  ],
                ),
              ),
              ],);
            } else if (state is MyFavoriteBooksFetched) {
              return _booksList(context, state.mybooks);
            } else {
              return const Text('Not support');
            }
          },
        ),
      
    );
  }
 
  Widget _booksList(context, List<Book> myfavoritebooks) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
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
                      showModal(context, myfavoritebooks);
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
              itemCount: myfavoritebooks.length,
              itemBuilder: (context, index) {
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
                            book.cover,
                        headers: {
                          'Authorization':
                              'Bearer ${PreferenceUtils.getString('token')}'},
                            width: 130,
                            height: 200,
                            fit: BoxFit.cover,
                          )),
                    ),
                    SizedBox(
                      height: 140,
                      child: Text(
                        utf8.decode(book.name.codeUnits),
                        style: BlookStyle.textCustom(
                            BlookStyle.whiteColor, BlookStyle.textSizeTwo),
                        textAlign: TextAlign.start,
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: BlookStyle.primaryColor,
                    elevation: 15.0,
                  ),
                  onPressed: () {
                    setState(() {
                      title="nombre de la A-Z";
                      books.sort((a, b) => b.name.compareTo(a.name));
                      Navigator.pop(context);
                    });
                  },
                  child: Text("Ordenar de A-Z",
                      style: BlookStyle.textCustom(
                          BlookStyle.whiteColor, BlookStyle.textSizeThree)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: BlookStyle.primaryColor,
                    elevation: 15.0,
                  ),
                  onPressed: () {
                    setState(() {
                      title="nombre de la Z-A";
                      books.sort((a, b) => a.name.compareTo(b.name));
                      Navigator.pop(context);
                    });
                  },
                  child: Text("Ordenar de Z-A",
                      style: BlookStyle.textCustom(
                          BlookStyle.whiteColor, BlookStyle.textSizeThree)),
                ),
              ],
            ),
          );
        });
  }
}
