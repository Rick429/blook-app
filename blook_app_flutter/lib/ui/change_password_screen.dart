import 'package:blook_app_flutter/utils/styles.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  TextEditingController password3Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BlookStyle.blackColor,
      appBar: AppBar(
        backgroundColor: BlookStyle.blackColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Center(
                child: Text(
                  "CAMBIAR CONTRASEÑA",
                  style: BlookStyle.textCustom(
                      BlookStyle.whiteColor, BlookStyle.textSizeFive),
                ),
              ),
              Container(
                height: 50,
                margin: const EdgeInsets.all(10),
                child: TextFormField(
                  style: BlookStyle.textCustom(
                      BlookStyle.whiteColor, BlookStyle.textSizeTwo),
                  controller: passwordController,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: BlookStyle.greyBoxColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    hintStyle: BlookStyle.textCustom(
                        BlookStyle.formColor, BlookStyle.textSizeTwo),
                    hintText: 'Contraseña actual:',
                  ),
                  onSaved: (String? value) {},
                  validator: (String? value) {
                    return (value == null)
                        ? 'Introduzca su contraseña actual'
                        : null;
                  },
                ),
              ),
              Container(
                height: 50,
                margin: const EdgeInsets.all(10),
                child: TextFormField(
                  style: BlookStyle.textCustom(
                      BlookStyle.whiteColor, BlookStyle.textSizeTwo),
                  controller: passwordController,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: BlookStyle.greyBoxColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    hintStyle: BlookStyle.textCustom(
                        BlookStyle.formColor, BlookStyle.textSizeTwo),
                    hintText: 'Nueva contraseña:',
                  ),
                  onSaved: (String? value) {},
                  validator: (String? value) {
                    return (value == null)
                        ? 'Introduzca su nueva contraseña'
                        : null;
                  },
                ),
              ),
              Container(
                height: 50,
                margin: const EdgeInsets.all(10),
                child: TextFormField(
                  style: BlookStyle.textCustom(
                      BlookStyle.whiteColor, BlookStyle.textSizeTwo),
                  controller: passwordController,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: BlookStyle.greyBoxColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    hintStyle: BlookStyle.textCustom(
                        BlookStyle.formColor, BlookStyle.textSizeTwo),
                    hintText: 'Confirmar contraseña nueva:',
                  ),
                  onSaved: (String? value) {},
                  validator: (String? value) {
                    return (value == null)
                        ? 'Repita su contraseña nueva'
                        : null;
                  },
                ),
              ),
              Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.fromLTRB(10, 200, 10, 8),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: BlookStyle.primaryColor,
                    elevation: 15.0,
                  ),
                  onPressed: () {},
                  child: Text("Guardar",
                      style: BlookStyle.textCustom(
                          BlookStyle.whiteColor, BlookStyle.textSizeThree))),
            )
            ],
          ),
        ),
      ),
    );
  }
}
