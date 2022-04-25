import 'package:blook_app_flutter/blocs/comment_new_bloc/comment_new_bloc.dart';
import 'package:blook_app_flutter/models/book_response.dart';
import 'package:blook_app_flutter/models/create_comment_dto.dart';
import 'package:blook_app_flutter/repository/comment_repository/comment_repository.dart';
import 'package:blook_app_flutter/repository/comment_repository/comment_repository_impl.dart';
import 'package:blook_app_flutter/ui/comments_screen.dart';
import 'package:blook_app_flutter/ui/menu_screen.dart';
import 'package:blook_app_flutter/utils/preferences.dart';
import 'package:blook_app_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentMenu extends StatefulWidget {
  const CommentMenu({Key? key}) : super(key: key);

  @override
  State<CommentMenu> createState() => _CommentMenuState();
}

class _CommentMenuState extends State<CommentMenu> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController commentController = TextEditingController();

  late CommentRepository commentRepository;
  @override
  void initState() {
    commentRepository = CommentRepositoryImpl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          return CommentNewBloc(commentRepository);
        },
        child: _createComment(context));
  }

  Widget _createComment(BuildContext context) {
    return BlocConsumer<CommentNewBloc, CommentNewState>(
        listenWhen: (context, state) {
      return state is CommentSuccessState || state is CommentErrorState;
    }, listener: (context, state) {
      if (state is CommentSuccessState) {
        Navigator.popAndPushNamed(context, "/comments");
      } else if (state is CommentErrorState) {
        _showSnackbar(context, state.message);
      }
    }, buildWhen: (context, state) {
      return state is CommentNewInitial || state is CommentLoadingState;
    }, builder: (ctx, state) {
      if (state is CommentNewInitial) {
        return _buildBottomBar(ctx);
      } else if (state is CommentLoadingState) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return _buildBottomBar(ctx);
      }
    });
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            border: Border(
          top: BorderSide(
            width: 1.0,
          ),
        )),
        padding: const EdgeInsets.all(20),
        height: 100,
        child: Form(
          key: _formKey,
          child: Row(
            children: [
              SizedBox(
                width: 292,
                child: TextFormField(
                  style: BlookStyle.textCustom(
                      BlookStyle.whiteColor, BlookStyle.textSizeTwo),
                  controller: commentController,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: BlookStyle.greyBoxColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    hintStyle: BlookStyle.textCustom(
                        BlookStyle.formColor, BlookStyle.textSizeTwo),
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Icon(Icons.comment),
                    ),
                    hintText: 'Escribir una reseña',
                  ),
                  onSaved: (String? value) {},
                  validator: (String? value) {
                    return (value == null) ? 'Escriba una reseña' : null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4),
                child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: BlookStyle.primaryColor),
                    child: GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            final createCommentDto = CreateCommentDto(
                                comment: commentController.text);
                            BlocProvider.of<CommentNewBloc>(context).add(
                                createCommentEvent(createCommentDto,
                                    PreferenceUtils.getString("idbook")!));
                          }
                        },
                        child: const Icon(
                          Icons.send,
                          color: BlookStyle.whiteColor,
                        ))),
              )
            ],
          ),
        ));
  }
}
