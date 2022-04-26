import 'dart:convert';

import 'package:blook_app_flutter/blocs/comments_bloc/comments_bloc.dart';
import 'package:blook_app_flutter/constants.dart';
import 'package:blook_app_flutter/repository/comment_repository/comment_repository.dart';
import 'package:blook_app_flutter/repository/comment_repository/comment_repository_impl.dart';
import 'package:blook_app_flutter/ui/comment_menu.dart';
import 'package:blook_app_flutter/utils/preferences.dart';
import 'package:blook_app_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/comment_response.dart';

class CommentsScren extends StatefulWidget {
  const CommentsScren({Key? key}) : super(key: key);

  @override
  State<CommentsScren> createState() => _CommentsScrenState();
}

class _CommentsScrenState extends State<CommentsScren> {
  late CommentRepository commentRepository;
  late CommentsBloc _commentsbloc;

  @override
  void initState() {
    PreferenceUtils.init();
    commentRepository = CommentRepositoryImpl();
    _commentsbloc = CommentsBloc(commentRepository)
      ..add(const FetchAllComments());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [BlocProvider(create: (context) => _commentsbloc)],
        child: Scaffold(
            bottomNavigationBar: const CommentMenu(),
            appBar: AppBar(
              backgroundColor: Colors.black,
              iconTheme: const IconThemeData(color: Colors.white),
              title: Center(
                child: Container(
                  margin: const EdgeInsets.only(right: 60),
                  child: Text(
                    "COMENTARIOS",
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
      child: BlocBuilder<CommentsBloc, CommentsState>(
        bloc: _commentsbloc,
        builder: (context, state) {
          if (state is CommentsInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CommentsFetchError) {
            return Center(
              child: Text(
                "No hay ningún comentario, se el primero en escribir algo",
                style: BlookStyle.textCustom(
                    BlookStyle.whiteColor, BlookStyle.textSizeTwo),
              ),
            );
          } else if (state is CommentsFetched) {
            return _commentsList(context, state.comments);
          } else {
            return const Text('Not support');
          }
        },
      ),
    );
  }

  Widget _commentsList(context, List<Comment> comentarios) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        margin: const EdgeInsets.only(bottom: 100),
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: comentarios.length,
          itemBuilder: (context, index) {
            return _comment(comentarios.elementAt(index));
          },
        ),
      ),
    );
  }

  Widget _comment(Comment comment) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: BlookStyle.greyBoxColor),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        'assets/images/portada.jpg',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        utf8.decode(comment.nick.codeUnits),
                        style: BlookStyle.textCustom(
                            BlookStyle.whiteColor, BlookStyle.textSizeOne),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 3.5),
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        comment.createdDate,
                        style: BlookStyle.textCustom(
                            BlookStyle.whiteColor, BlookStyle.textSizeOne),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 8.0),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  utf8.decode(comment.comment.codeUnits),
                  style: BlookStyle.textCustom(
                      BlookStyle.whiteColor, BlookStyle.textSizeOne),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                        onTap: () {
                          PreferenceUtils.setString(
                              Constant.typereport, "COMENTARIO");
                          PreferenceUtils.setString("idbook", comment.bookId);
                          Navigator.pushNamed(context, '/report');
                        },
                        child: const Icon(Icons.report_problem_rounded,
                            color: BlookStyle.whiteColor)),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
