import 'dart:convert';

import 'package:blook_app_flutter/models/book_response.dart';
import 'package:blook_app_flutter/models/genre_response.dart';
import 'package:blook_app_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';


class InfoBookScrenn extends StatefulWidget {
  final Book book;
  const InfoBookScrenn({required this.book, Key? key}) : super(key: key);

  @override
  State<InfoBookScrenn> createState() => _InfoBookScrennState(book);
}

class _InfoBookScrennState extends State<InfoBookScrenn> {
  final Book libro;
  _InfoBookScrennState(this.libro);
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
            padding: EdgeInsets.all(12),
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
                      Text(utf8.decode(libro.name.codeUnits),
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
                      Text(utf8.decode(libro.autor.codeUnits),
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
                     Text('${Jiffy(libro.releaseDate).yMMMd}' ,
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
                       margin: EdgeInsets.only(top:15),
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
              
                  child: GenreList(context, libro.genres),
                ),




                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Text("SINOPSIS",
                            style: BlookStyle.textCustom(
                              BlookStyle.whiteColor,
                              BlookStyle.textSizeFour,
                            ),),
                  ),
             
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                child: Text(utf8.decode(libro.description.codeUnits),
                        style: BlookStyle.textCustom(
                          BlookStyle.whiteColor,
                          BlookStyle.textSizeTwo,
                        ),),
              )
              ],
            ),
          ),
        ),
        
        );
  }

  Widget GenreList(context, List<Genre> listagenres){
    if(listagenres.isEmpty){
      return Text("Sin definir",
                          style: BlookStyle.textCustom(
                            BlookStyle.whiteColor,
                            BlookStyle.textSizeTwo,
                          ),
      );
                 
    } else {
      return ListView.builder(
                shrinkWrap: false,
                scrollDirection: Axis.horizontal,
                itemCount: libro.genres.length,
                
                itemBuilder: (context, index) {
                  listagenres = libro.genres;
                  print("${libro.genres.length }tamanio de los generos");
                  print("${listagenres.toString() }tamanio de losdasda generos");
                  
                    
                    
                     return oneGenre(context, listagenres.elementAt(index));
                  
                 
                },
              
            );
    }
  }

   Widget oneGenre (context, Genre genre) {
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
                          BlookStyle.whiteColor, BlookStyle.textSizeTwo),textAlign: TextAlign.center,
                    ));
  }
}
