import 'package:blook_app_flutter/blocs/book_new_bloc/book_new_bloc.dart';
import 'package:blook_app_flutter/blocs/my_books_bloc/my_books_bloc.dart';
import 'package:blook_app_flutter/models/book_response.dart';
import 'package:blook_app_flutter/repository/book_repository/book_repository.dart';
import 'package:blook_app_flutter/repository/book_repository/book_repository_impl.dart';
import 'package:blook_app_flutter/ui/comment_menu.dart';
import 'package:blook_app_flutter/ui/comments_screen.dart';
import 'package:blook_app_flutter/utils/preferences.dart';
import 'package:blook_app_flutter/utils/styles.dart';
import 'package:blook_app_flutter/widgets/error_page.dart';
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

  @override
  void initState() {
    PreferenceUtils.init();
    bookRepository = BookRepositoryImpl();
    _mybooksbloc = MyBooksBloc(bookRepository)..add(FetchAllMyBooks());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => _mybooksbloc)
        ],
        child: Scaffold(
            backgroundColor: BlookStyle.blackColor,
        appBar: const HomeAppBar(),
            body: RefreshIndicator(
                onRefresh: () async {},
                child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: _createBody(context)))));
  }

  Widget _createBody(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child:  BlocBuilder<MyBooksBloc, MyBooksState>(
          bloc: _mybooksbloc,
          builder: (context, state) {
            if (state is MyBooksInitial) {
              return Container(
                  child: const Center(child: CircularProgressIndicator()));
            } else if (state is MyBooksFetchError) {
              return Column(children: [
                  Center(
                child: Text("MIS LIBROS",
                    style: BlookStyle.textCustom(
                        BlookStyle.whiteColor, BlookStyle.textSizeFive)),
              ),Container(
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
            } else if (state is MyBooksFetched) {
              return _booksList(context, state.mybooks);
            } else {
              return const Text('Not support');
            }
          },
        ),
      
    );
  }

Widget _booksList(context, List<Book> mybooks) {
  return  SizedBox(
    height: MediaQuery.of(context).size.height,
    child: Column(
      children: [
        Center(
                child: Text("MIS LIBROS",
                    style: BlookStyle.textCustom(
                        BlookStyle.whiteColor, BlookStyle.textSizeFive)),
              ),Container(
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
        Container(
          margin: const EdgeInsets.only(bottom: 100),
          height: 500,
          child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
            itemCount: mybooks.length,
            itemBuilder: (context, index) {
            return _bookItem(mybooks.elementAt(index));
            },
            ),
          ),
      ],
    ),
  );
  }

   Widget _bookItem(Book book) {

    return Column(children: [

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
                      height: 190,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            book.name,
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
                                    const Icon(Icons.remove_red_eye, color: BlookStyle.whiteColor,),
                                    Text("3700", style: BlookStyle.textCustom(BlookStyle.whiteColor, BlookStyle.textSizeTwo),)
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                     Navigator.of(context).push(
                                       MaterialPageRoute(builder: (context)=>CommentsScren(comments: book.comments,)));
                                  
                                    
                                  },
                                  child: Column(
                                    children: [
                                      const Icon(Icons.comment, color: BlookStyle.whiteColor),
                                      Text("2500", style: BlookStyle.textCustom(BlookStyle.whiteColor, BlookStyle.textSizeTwo),)
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
    ],); }

 
          
            
                
              
            
       
  
}
