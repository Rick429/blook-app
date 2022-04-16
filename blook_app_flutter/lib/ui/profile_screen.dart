import 'package:blook_app_flutter/constants.dart';
import 'package:blook_app_flutter/utils/styles.dart';
import 'package:blook_app_flutter/widgets/home_app_bar.dart';
import 'package:flutter/material.dart';

import '../utils/preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}



class _ProfileScreenState extends State<ProfileScreen> {

  @override
  void initState() {
    PreferenceUtils.init();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BlookStyle.blackColor,
      appBar: const HomeAppBar(),
      body: ListView(
        children: [
          Center(
            child: Text("MI PERFIL",
                style: BlookStyle.textCustom(
                    BlookStyle.whiteColor, BlookStyle.textSizeFive)),
          ),
          Container(
              width: 130,
              height: 130,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/portada.jpg")))),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text("Nombre de usuario",
                  style: BlookStyle.textCustom(
                      BlookStyle.whiteColor, BlookStyle.textSizeThree)),
            ),
          ),
          Container(
            height: 40,
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: BlookStyle.greyBoxColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Nombre:",
                    style: BlookStyle.textCustom(
                        BlookStyle.whiteColor, BlookStyle.textSizeTwo),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text("nombre1",
                      style: BlookStyle.textCustom(
                          BlookStyle.whiteColor, BlookStyle.textSizeTwo)),
                )
              ],
            ),
          ),
          Container(
            height: 40,
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: BlookStyle.greyBoxColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Apellidos:",
                    style: BlookStyle.textCustom(
                        BlookStyle.whiteColor, BlookStyle.textSizeTwo),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text("apellido1",
                      style: BlookStyle.textCustom(
                          BlookStyle.whiteColor, BlookStyle.textSizeTwo)),
                ),
              ],
            ),
          ),
          Container(
            height: 40,
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: BlookStyle.greyBoxColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Correo eléctronico:",
                    style: BlookStyle.textCustom(
                        BlookStyle.whiteColor, BlookStyle.textSizeTwo),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text("correo1",
                      style: BlookStyle.textCustom(
                          BlookStyle.whiteColor, BlookStyle.textSizeTwo)),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: BlookStyle.greyBoxColor,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: BlookStyle.formColor, width: 2),
                  borderRadius: BorderRadius.circular(25),
                ),
                elevation: 15.0,
              ),
              onPressed: () {
                 Navigator.pushNamed(context, '/changepassword');
              },
              child: Text(
                "Cambiar contraseña",
                style: BlookStyle.textCustom(
                    BlookStyle.whiteColor, BlookStyle.textSizeTwo),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(8, 50, 8, 8),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: BlookStyle.redColor,
                  elevation: 15.0,
                ),
                onPressed: () {
                  PreferenceUtils.remove(Constant.token);
                  Navigator.pushNamed(context, '/login');
                },
                child: Text("Cerrar sesión",
                    style: BlookStyle.textCustom(
                        BlookStyle.whiteColor, BlookStyle.textSizeThree))),
          )
        ],
      ),
    );
  }
}
