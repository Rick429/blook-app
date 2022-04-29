import 'package:blook_app_flutter/models/book_response.dart';
import 'package:flutter/material.dart';

class InfoBookScrenn extends StatefulWidget {
  final Book book;
  const InfoBookScrenn({ required this.book, Key? key }) : super(key: key);

  @override
  State<InfoBookScrenn> createState() => _InfoBookScrennState(book);
}

class _InfoBookScrennState extends State<InfoBookScrenn> {
  final Book libro;
  _InfoBookScrennState(this.libro);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(libro.name),
    );
  }
}