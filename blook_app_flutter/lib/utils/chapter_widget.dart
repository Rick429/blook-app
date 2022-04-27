import 'dart:convert';

import 'package:blook_app_flutter/blocs/book_bloc/book_bloc.dart';
import 'package:blook_app_flutter/blocs/delete_chapter_bloc/delete_chapter_bloc.dart';
import 'package:blook_app_flutter/models/book_response.dart';
import 'package:blook_app_flutter/repository/chapter_repository/chapter_repository.dart';
import 'package:blook_app_flutter/repository/chapter_repository/chapter_repository_impl.dart';
import 'package:blook_app_flutter/ui/menu_screen.dart';
import 'package:blook_app_flutter/utils/preferences.dart';
import 'package:blook_app_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChapterWidget extends StatefulWidget {
  final String idChapter;
  final int index;
  final String bookAutor;
  final String chapterName;
  const ChapterWidget(
      {Key? key,
      required this.idChapter,
      required this.index,
      required this.bookAutor,
      required this.chapterName})
      : super(key: key);

  @override
  State<ChapterWidget> createState() =>
      _ChapterWidgetState(idChapter, index, bookAutor, chapterName);
}

class _ChapterWidgetState extends State<ChapterWidget> {
  final String idCapitulo;
  final int indice;
  final String autorLibro;
  final String capituloNombre;
  _ChapterWidgetState(
      this.idCapitulo, this.indice, this.autorLibro, this.capituloNombre);

  @override
  void initState() {
    PreferenceUtils.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if (PreferenceUtils.getString("nick") == autorLibro) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 250,
            child: Text(
              "Capitulo ${indice + 1}: " +
                  utf8.decode(capituloNombre.codeUnits),
              style: BlookStyle.textCustom(
                  BlookStyle.whiteColor, BlookStyle.textSizeTwo),
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios_sharp,
            color: BlookStyle.whiteColor,
          ),
          GestureDetector(
            onTap: () {
              BlocProvider.of<DeleteChapterBloc>(context)
                  .add(DeleteOneChapterEvent(idCapitulo));
            },
            child: const Icon(
              Icons.delete,
              color: BlookStyle.whiteColor,
            ),
          )
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Capitulo ${indice + 1}: " + utf8.decode(capituloNombre.codeUnits),
            style: BlookStyle.textCustom(
                BlookStyle.whiteColor, BlookStyle.textSizeTwo),
          ),
          const Icon(
            Icons.arrow_forward_ios_sharp,
            color: BlookStyle.whiteColor,
          )
        ],
      );
    }
  }
}
