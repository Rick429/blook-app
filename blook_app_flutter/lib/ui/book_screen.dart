import 'package:blook_app_flutter/blocs/book_bloc/book_bloc.dart';
import 'package:blook_app_flutter/blocs/book_favorite_bloc/book_favorite_bloc.dart';
import 'package:blook_app_flutter/models/book_response.dart';
import 'package:blook_app_flutter/repository/book_repository/book_repository.dart';
import 'package:blook_app_flutter/repository/book_repository/book_repository_impl.dart';
import 'package:blook_app_flutter/ui/menu_screen.dart';
import 'package:blook_app_flutter/ui/pdf_viewer.dart';
import 'package:blook_app_flutter/utils/preferences.dart';
import 'package:blook_app_flutter/utils/styles.dart';
import 'package:blook_app_flutter/widgets/error_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({Key? key}) : super(key: key);

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  late BookRepository bookRepository;
  late BookBloc _oneBookBloc;

  @override
  void initState() {
    PreferenceUtils.init();
    bookRepository = BookRepositoryImpl();
    _oneBookBloc = BookBloc(bookRepository)..add(const FetchOneBook());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => _oneBookBloc),
          BlocProvider(create: (context) => BookFavoriteBloc(bookRepository))
        ],
        child: Scaffold(
            backgroundColor: BlookStyle.blackColor,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            body: RefreshIndicator(
                onRefresh: () async {},
                child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: _createBody(context)))));
  }

  Widget _createBody(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          BlocBuilder<BookBloc, BookState>(
            bloc: _oneBookBloc,
            builder: (context, state) {
              if (state is BookInitial) {
                return Container(
                    child: const Center(child: CircularProgressIndicator()));
              } else if (state is OneBookFetchError) {
                return ErrorPage(
                  message: state.message,
                  retry: () {
                    context.watch<BookBloc>().add(FetchOneBook());
                  },
                );
              } else if (state is OneBookFetched) {
                return buildOne(context, state.book);
              } else {
                return const Text('Not support');
              }
            },
          ),

          BlocConsumer<BookFavoriteBloc, BookFavoriteState>(
                listenWhen: (context, state) {
              return state is BookFavorite || state is BookFavoriteError;
            }, listener: (context, state) {
              if (state is BookFavorite) {
                
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MenuScreen()),
                );
              } else if (state is BookFavoriteError) {
                _showSnackbar(context, state.message);
              }
            }, buildWhen: (context, state) {
              return state is BookFavoriteInitial;
            }, builder: (ctx, state) {
              if (state is BookFavoriteInitial) {
                return favorite(ctx);
              } else {
                return favorite(ctx);
              }
            })
        ],
      ),
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget favorite (context) {
    return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children:  [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        BlocProvider.of<BookFavoriteBloc>(context)
                              .add(AddBookFavorite());
                      },
                      child: const Icon(Icons.favorite_border_outlined),),
                  ),
                ],
              );
  }

  Widget buildOne(context, Book book) {
    var lista;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: ListView(
        children: [
          Stack(
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    book.cover,
                    headers: {
                      'Authorization':
                          'Bearer ${PreferenceUtils.getString('token')}'
                    },
                    height: 260,
                    width: 50,
                    fit: BoxFit.cover,
                  )),
              Container(
                height: 260,
                decoration: BoxDecoration(color: Colors.grey.withOpacity(0.5)),
              ),
              favorite(context),
              Container(
                height: 250,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          book.cover,
                          headers: {
                            'Authorization':
                                'Bearer ${PreferenceUtils.getString('token')}'
                          },
                          height: 200,
                          fit: BoxFit.cover,
                        )),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 40, horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 200,
                            child: Text(
                              book.name,
                              style: BlookStyle.textCustom(
                                  BlookStyle.whiteColor, BlookStyle.textSizeFive),
                            ),
                          ),
                          SizedBox(
                            width: 200,
                            child: Text(
                              book.autor,
                              style: BlookStyle.textCustom(
                                  BlookStyle.whiteColor, BlookStyle.textSizeFour),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 260,
                width: MediaQuery.of(context).size.width,
                child: const Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Icon(
                      Icons.edit,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "SINOPSIS",
              style: BlookStyle.textCustom(
                BlookStyle.whiteColor,
                BlookStyle.textSizeThree,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              book.description,
              style: BlookStyle.textCustom(
                BlookStyle.whiteColor,
                BlookStyle.textSizeTwo,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: BlookStyle.primaryColor,
                  elevation: 15.0,
                ),
                onPressed: () {},
                child: Text("Ver información",
                    style: BlookStyle.textCustom(
                        BlookStyle.whiteColor, BlookStyle.textSizeThree))),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "CAPÍTULOS",
                  style: BlookStyle.textCustom(
                    BlookStyle.whiteColor,
                    BlookStyle.textSizeThree,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    PreferenceUtils.setString("idBook", book.id);
                    Navigator.pushNamed(context, '/chapternew');
                  },
                  child: Container(
                    width: 50,
                    height: 30,
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        color: BlookStyle.primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      "+",
                      style: BlookStyle.textCustom(
                          BlookStyle.whiteColor, BlookStyle.textSizeThree),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            height: 30,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  width: 70,
                  height: 20,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: BlookStyle.quaternaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "1-5",
                    style: BlookStyle.textCustom(
                        BlookStyle.whiteColor, BlookStyle.textSizeOne),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: 70,
                  height: 20,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: BlookStyle.quaternaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "1-5",
                    style: BlookStyle.textCustom(
                        BlookStyle.whiteColor, BlookStyle.textSizeOne),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: 70,
                  height: 20,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: BlookStyle.quaternaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "1-5",
                    style: BlookStyle.textCustom(
                        BlookStyle.whiteColor, BlookStyle.textSizeOne),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: 70,
                  height: 20,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: BlookStyle.quaternaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "1-5",
                    style: BlookStyle.textCustom(
                        BlookStyle.whiteColor, BlookStyle.textSizeOne),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: 70,
                  height: 20,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: BlookStyle.quaternaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "1-5",
                    style: BlookStyle.textCustom(
                        BlookStyle.whiteColor, BlookStyle.textSizeOne),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 150),
            padding: EdgeInsets.only(bottom: 50),
            height: 300,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: book.chapters.length,
              itemBuilder: (context, index) {
                lista = book.chapters;
                return _chapterItem(lista.elementAt(index), index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _chapterItem(Chapter chapter, index) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: BlookStyle.greyBoxColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          elevation: 15.0,
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PdfViewer(document: chapter.file)));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Capitulo ${index + 1}: " + chapter.name,
              style: BlookStyle.textCustom(
                  BlookStyle.whiteColor, BlookStyle.textSizeTwo),
            ),
            const Icon(
              Icons.arrow_forward_ios_sharp,
              color: BlookStyle.whiteColor,
            )
          ],
        ),
      ),
    );
  }
}
