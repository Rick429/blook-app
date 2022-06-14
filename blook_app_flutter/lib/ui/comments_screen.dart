import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:blook_app_flutter/blocs/comments_bloc/comments_bloc.dart';
import 'package:blook_app_flutter/blocs/delete_comment_bloc/delete_comment_bloc.dart';
import 'package:blook_app_flutter/blocs/edit_comment_dto/edit_comment_bloc.dart';
import 'package:blook_app_flutter/constants.dart';
import 'package:blook_app_flutter/repository/comment_repository/comment_repository.dart';
import 'package:blook_app_flutter/repository/comment_repository/comment_repository_impl.dart';
import 'package:blook_app_flutter/ui/comment_menu.dart';
import 'package:blook_app_flutter/utils/preferences.dart';
import 'package:blook_app_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import '../models/comment_response.dart';

class CommentsScren extends StatefulWidget {
  const CommentsScren({Key? key}) : super(key: key);

  @override
  State<CommentsScren> createState() => _CommentsScrenState();
}

class _CommentsScrenState extends State<CommentsScren> {
    final box = GetStorage();
  bool _isEditingText = false;

  late CommentRepository commentRepository;
  late CommentsBloc _commentsbloc;
  @override
  void initState() {
  
    commentRepository = CommentRepositoryImpl();
    _commentsbloc = CommentsBloc(commentRepository)
      ..add(const FetchAllComments());
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => _commentsbloc),
          BlocProvider(create: (context) => EditCommentBloc(commentRepository)),
          BlocProvider(
              create: (context) => DeleteCommentBloc(commentRepository)),
        ],
        child: Scaffold(
            bottomNavigationBar: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: const CommentMenu(),
            ),
            appBar: AppBar(
              backgroundColor: Colors.black,
              iconTheme: const IconThemeData(color: Colors.white),
              centerTitle: true,
              title: Text(
                "Reseñas",
                style: BlookStyle.textCustom(
                    BlookStyle.whiteColor, BlookStyle.textSizeFive),
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
      child: Column(
        children: [
          BlocBuilder<CommentsBloc, CommentsState>(
            bloc: _commentsbloc,
            builder: (context, state) {
              if (state is CommentsInitial) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is CommentsFetchError) {
                return Center(
                  child: Text(
                    "No hay ninguna reseña, sé el primero en escribir algo",
                    style: BlookStyle.textCustom(
                        BlookStyle.whiteColor, BlookStyle.textSizeTwo),
                  ),
                );
              } else if (state is CommentsFetched) {
                box.write("commentF", "");
                return _commentsList(context, state.comments);
              } else {
                return const Text('No se ha podido cargar las reseñas');
              }
            },
          ),
          BlocConsumer<EditCommentBloc, EditCommentState>(
              listenWhen: (context, state) {
            return state is EditCommentSuccessState;
          }, listener: (context, state) {
            if (state is EditCommentSuccessState) {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(pageBuilder: (_, __, ___) => const CommentsScren()),
              );
            } else if (state is EditCommentErrorState) {
              _showSnackbar(context, state.message);
            }
          }, buildWhen: (context, state) {
            return state is EditCommentInitial ||
                state is EditCommentSuccessState;
          }, builder: (context, state) {
            if (state is EditCommentSuccessState) {
              return Container();
            }
            return Container();
          }),
          BlocConsumer<DeleteCommentBloc, DeleteCommentState>(
              listenWhen: (context, state) {
            return state is DeleteSuccessState || state is DeleteErrorState;
          }, listener: (context, state) {
            if (state is DeleteSuccessState) {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(pageBuilder: (_, __, ___) => const CommentsScren()),
              );
            } else if (state is DeleteErrorState) {
              _showSnackbar(context, state.message);
            }
          }, buildWhen: (context, state) {
            return state is DeleteCommentInitial;
          }, builder: (ctx, state) {
            if (state is DeleteCommentInitial) {
              return Container();
            } else {
              return Container();
            }
          }),
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
            return _comment(context, comentarios.elementAt(index));
          },
        ),
      ),
    );
  }

  Widget _comment(context, Comment comment) {
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: avatar(comment.avatar),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            utf8.decode(comment.nick.codeUnits),
                            style: BlookStyle.textCustom(
                                BlookStyle.whiteColor, BlookStyle.textSizeOne),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 8),
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
              /*  _editTitleTextField(context, comment), */
              Container(
                padding: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _editButton(context, comment),
                    _deleteButton(context, comment),
                    GestureDetector(
                        onTap: () {
                          box.write(
                              Constant.typereport, "COMENTARIO");
                          box.write("idbook", comment.bookId);
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

  Widget avatar(String avatarUrl) {
    if (avatarUrl.isEmpty) {
      return Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/images/upload.png"))));
    } else {
      return Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(
              box.read("avatar")!,
            ),
          ),
        ),
      );
    }
  }

  Widget _editButton(context, Comment comment) {
    if (comment.nick == box.read("nick")) {
      return GestureDetector(
          onTap: () {
            setState(() {
              box.write("exists", false);
              box.write("commentF", comment.comment);
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(pageBuilder: (_, __, ___) => const CommentsScren()),
              );
              _isEditingText = true;
         
            });
          },
          child: const Icon(Icons.edit, color: BlookStyle.whiteColor));
    } else {
      return Container();
    }
  }

  Widget _deleteButton(BuildContext context, Comment comment) {
    if (comment.nick == box.read("nick")) {
      return GestureDetector(
          onTap: () {
            _createDeleteDialog(context, comment.bookId);
          },
          child: const Icon(Icons.delete, color: BlookStyle.whiteColor));
    } else {
      return Container();
    }
  }

  AwesomeDialog _createDeleteDialog(context, String id) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.INFO,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Eliminar',
      desc: '¿Seguro que desea eliminar la reseña?',
      btnCancelText: "Cancelar",
      btnOkText: "Eliminar",
      dialogBackgroundColor: BlookStyle.quaternaryColor,
      btnOkColor: BlookStyle.primaryColor,
      btnCancelColor: BlookStyle.redColor,
      titleTextStyle:
          BlookStyle.textCustom(BlookStyle.whiteColor, BlookStyle.textSizeFour),
      descTextStyle: BlookStyle.textCustom(
          BlookStyle.whiteColor, BlookStyle.textSizeThree),
      btnOkOnPress: () {
        BlocProvider.of<DeleteCommentBloc>(context)
            .add(DeleteOneCommentEvent(id));
      },
      btnCancelOnPress: () {},
    )..show();
  }

}
