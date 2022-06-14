import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:blook_app_flutter/blocs/book_bloc/book_bloc.dart';
import 'package:blook_app_flutter/blocs/delete_chapter_bloc/delete_chapter_bloc.dart';
import 'package:blook_app_flutter/models/book_response.dart';
import 'package:blook_app_flutter/repository/chapter_repository/chapter_repository.dart';
import 'package:blook_app_flutter/repository/chapter_repository/chapter_repository_impl.dart';
import 'package:blook_app_flutter/ui/chapter_edit_screen.dart';
import 'package:blook_app_flutter/ui/menu_screen.dart';
import 'package:blook_app_flutter/utils/preferences.dart';
import 'package:blook_app_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

class ChapterWidget extends StatefulWidget {
  final String idCapitulo;
  final int indice;
  final String autorLibro;
  final String capituloNombre;
  const ChapterWidget(
      {Key? key,
      required this.idCapitulo,
      required this.indice,
      required this.autorLibro,
      required this.capituloNombre})
      : super(key: key);

  @override
  State<ChapterWidget> createState() =>_ChapterWidgetState();
}

class _ChapterWidgetState extends State<ChapterWidget> {
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (box.read("nick") == widget.autorLibro) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 220,
            child: Text(
              "Capitulo ${widget.indice + 1}: " +
                  utf8.decode(widget.capituloNombre.codeUnits),
              style: BlookStyle.textCustom(
                  BlookStyle.whiteColor, BlookStyle.textSizeTwo),
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios_sharp,
            color: BlookStyle.whiteColor,
          ),
          IconButton(onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => ChapterEditScreen(nombreCapitulo: widget.capituloNombre, idCapitulo: widget.idCapitulo,)));
          }, icon: const Icon(Icons.edit),
            color: BlookStyle.whiteColor,),
          IconButton(
              onPressed: () {
                _createDialog(context, widget.idCapitulo);
              },
              icon: const Icon(Icons.delete))
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Capitulo ${widget.indice + 1}: " + utf8.decode(widget.capituloNombre.codeUnits),
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

  AwesomeDialog _createDialog(context, String id) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.INFO,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Eliminar',
      desc: '¿Seguro que desea eliminar el capítulo?',
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
        BlocProvider.of<DeleteChapterBloc>(context)
            .add(DeleteOneChapterEvent(widget.idCapitulo));
      },
      btnCancelOnPress: () {},
    )..show();
  }
}
