import 'dart:convert';
import 'package:blook_app_flutter/models/book_response.dart';
import 'package:blook_app_flutter/models/genre_response.dart';
import 'package:blook_app_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class InfoBookScrenn extends StatefulWidget {
  final Book libro;
  const InfoBookScrenn({required this.libro, Key? key}) : super(key: key);

  @override
  State<InfoBookScrenn> createState() => _InfoBookScrennState();
}

class _InfoBookScrennState extends State<InfoBookScrenn> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          "INFORMACIÓN",
          style: BlookStyle.textCustom(
              BlookStyle.whiteColor, BlookStyle.textSizeFive),
        ),
      ),
      backgroundColor: BlookStyle.blackColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'NOMBRE: ',
                    style: BlookStyle.textCustom(
                      BlookStyle.whiteColor,
                      BlookStyle.textSizeThree,
                    ),
                  ),
                  Text(
                    utf8.decode(widget.libro.name.codeUnits),
                    style: BlookStyle.textCustom(
                      BlookStyle.whiteColor,
                      BlookStyle.textSizeTwo,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'AUTOR: ',
                    style: BlookStyle.textCustom(
                      BlookStyle.whiteColor,
                      BlookStyle.textSizeThree,
                    ),
                  ),
                  Text(
                    utf8.decode(widget.libro.autor.codeUnits),
                    style: BlookStyle.textCustom(
                      BlookStyle.whiteColor,
                      BlookStyle.textSizeTwo,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'FECHA DE PUBLICACIÓN: ',
                    style: BlookStyle.textCustom(
                      BlookStyle.whiteColor,
                      BlookStyle.textSizeThree,
                    ),
                  ),
                  Text(
                    Jiffy(widget.libro.releaseDate).yMMMd,
                    style: BlookStyle.textCustom(
                      BlookStyle.whiteColor,
                      BlookStyle.textSizeTwo,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    child: Text(
                      'GÉNEROS ',
                      style: BlookStyle.textCustom(
                        BlookStyle.whiteColor,
                        BlookStyle.textSizeFour,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: genreList(context, widget.libro.genres),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15),
                child: Text(
                  "SINOPSIS",
                  style: BlookStyle.textCustom(
                    BlookStyle.whiteColor,
                    BlookStyle.textSizeFour,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  utf8.decode(widget.libro.description.codeUnits),
                  style: BlookStyle.textCustom(
                    BlookStyle.whiteColor,
                    BlookStyle.textSizeTwo,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget genreList(context, List<Genre> listagenres) {
    if (listagenres.isEmpty) {
      return Text(
        "Sin definir",
        style: BlookStyle.textCustom(
          BlookStyle.whiteColor,
          BlookStyle.textSizeTwo,
        ),
      );
    } else {
      return ListView.builder(
        shrinkWrap: false,
        scrollDirection: Axis.horizontal,
        itemCount: widget.libro.genres.length,
        itemBuilder: (context, index) {
          listagenres = widget.libro.genres;
          return oneGenre(context, listagenres.elementAt(index));
        },
      );
    }
  }

  Widget oneGenre(context, Genre genre) {
    return Container(
        width: 60,
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.only(top: 6),
        decoration: BoxDecoration(
            border: Border.all(color: BlookStyle.whiteColor),
            borderRadius: BorderRadius.circular(5)),
        child: Text(
          utf8.decode(genre.name.codeUnits),
          style: BlookStyle.textCustom(
              BlookStyle.whiteColor, BlookStyle.textSizeTwo),
          textAlign: TextAlign.center,
        ));
  }
}
