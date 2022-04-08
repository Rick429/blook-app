import 'package:blook_app_flutter/utils/styles.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Container(
            margin: const EdgeInsets.only(right: 60),
            child: Text(
              "BUSCADOR",
              style: BlookStyle.textCustom(
                  BlookStyle.whiteColor, BlookStyle.textSizeFive),
            ),
          ),
        ),
        backgroundColor: BlookStyle.blackColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: BlookStyle.blackColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              Form(
                key: _formKey,
                child: Container(
                  height: 50,
                  margin: const EdgeInsets.all(10),
                  child: TextFormField(
                    style: BlookStyle.textCustom(
                        BlookStyle.blackColor, BlookStyle.textSizeTwo),
                    controller: searchController,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: BlookStyle.whiteColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      hintStyle: BlookStyle.textCustom(
                          BlookStyle.blackColor, BlookStyle.textSizeTwo),
                      hintText: 'Buscar...',
                    ),
                    onSaved: (String? value) {},
                    validator: (String? value) {
                      return (value == null)
                          ? 'Introduzca el nombre de un libro'
                          : null;
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
