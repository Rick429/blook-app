import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:blook_app_flutter/blocs/chapter_new_bloc/chapter_new_bloc.dart';
import 'package:blook_app_flutter/blocs/edit_chapter_bloc/edit_chapter_bloc.dart';
import 'package:blook_app_flutter/constants.dart';
import 'package:blook_app_flutter/models/create_chapter_dto.dart';
import 'package:blook_app_flutter/repository/chapter_repository/chapter_repository.dart';
import 'package:blook_app_flutter/repository/chapter_repository/chapter_repository_impl.dart';
import 'package:blook_app_flutter/ui/menu_screen.dart';
import 'package:blook_app_flutter/utils/preferences.dart';
import 'package:blook_app_flutter/utils/styles.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality);

class ChapterEditScreen extends StatefulWidget {
  final String nameChapter;
  final String idChapter;
  const ChapterEditScreen({Key? key, required this.nameChapter, required this.idChapter,}) : super(key: key);

  @override
  State<ChapterEditScreen> createState() => _ChapterEditScreenState(nameChapter, idChapter);
}

class _ChapterEditScreenState extends State<ChapterEditScreen> {
  final String nombreCapitulo;
  final String idCapitulo;
  _ChapterEditScreenState(this.nombreCapitulo, this.idCapitulo);
  List<XFile>? _imageFileList;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late ChapterRepository chapterRepository;

  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : <XFile>[value];
  }

  @override
  void initState() {
    chapterRepository = ChapterRepositoryImpl();
    PreferenceUtils.setString('image', '...');
    nameController = TextEditingController(text: nombreCapitulo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          return EditChapterBloc(chapterRepository);
        },
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              iconTheme: const IconThemeData(color: Colors.white),
              centerTitle: true,
              title: Text(
                    "EDITAR CAPÍTULO",
                    style: BlookStyle.textCustom(
                        BlookStyle.whiteColor, BlookStyle.textSizeFive),
              ),
            ),
            backgroundColor: BlookStyle.blackColor,
            body: RefreshIndicator(
                onRefresh: () async {},
                child: SingleChildScrollView(child: _createBody(context)))));
  }

  Widget _createBody(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(top: 70.0),
        child: Column(children: [
          BlocConsumer<EditChapterBloc, EditChapterState>(
              listenWhen: (context, state) {
            return state is EditChapterSuccessState ||
                state is EditChapterErrorState;
          }, listener: (context, state) {
            if (state is EditChapterSuccessState) {
          
              _createDialog(context);
            } else if (state is EditChapterErrorState) {
              _showSnackbar(context, state.toString());
            }
          }, buildWhen: (context, state) {
            return state is EditChapterInitial;
          }, builder: (ctx, state) {
            if (state is EditChapterInitial) {
              return buildF(ctx);
            } else {
              return buildF(ctx);
            }
          }),
        ]),
      ),
    );
  }


  AwesomeDialog _createDialog(context) {
    return AwesomeDialog(
      context: context,
      dialogBackgroundColor: BlookStyle.quaternaryColor,
      btnOkColor: BlookStyle.primaryColor,
      dialogType: DialogType.SUCCES,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Correcto',
      desc: 'El libro se ha editado correctamente',
      titleTextStyle:
          BlookStyle.textCustom(BlookStyle.whiteColor, BlookStyle.textSizeFour),
      descTextStyle: BlookStyle.textCustom(
          BlookStyle.whiteColor, BlookStyle.textSizeThree),
      btnOkText: "Aceptar",
      btnOkOnPress: () {},
    )..show();
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget buildF(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                height: 50,
                margin: const EdgeInsets.all(10),
                child: TextFormField(
                  style: BlookStyle.textCustom(
                      BlookStyle.whiteColor, BlookStyle.textSizeTwo),
                  controller: nameController,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: BlookStyle.greyBoxColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    hintStyle: BlookStyle.textCustom(
                        BlookStyle.formColor, BlookStyle.textSizeTwo),
                    hintText: 'Nombre del capítulo',
                  ),
                  onSaved: (String? value) {},
                  validator: (String? value) {
                    return (value == null)
                        ? 'Introduzca el nombre del capítulo'
                        : null;
                  },
                ),
              ),
              Container(
                height: 50,
                margin: const EdgeInsets.all(10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: BlookStyle.greyBoxColor,
                    elevation: 15.0,
                  ),
                  onPressed: () async {
                    final FilePicker _picker = FilePicker.platform;
                    final FilePickerResult? pickedFile =
                        await _picker.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: [/* 'jpg',  */'pdf'/* , 'doc' */],
                    );
                    setState(() {
                      PreferenceUtils.setString(
                          'image', pickedFile!.files[0].path ?? "");
                    });
                  },
                  child: Text(
                    "Seleccionar Archivo",
                    style: BlookStyle.textCustom(
                        BlookStyle.whiteColor, BlookStyle.textSizeTwo),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                height: 60,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: BlookStyle.secondaryColor.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  PreferenceUtils.getString('image')!,
                  style: BlookStyle.textCustom(
                      BlookStyle.whiteColor, BlookStyle.textSizeTwo),
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final createChapterDto =
                            CreateChapterDto(name: nameController.text);
                        if (!PreferenceUtils.getString("image")!
                            .endsWith('.pdf')&&PreferenceUtils.getString("image")!='...') {
                          _createDialogC(context);
                        } else {
                          BlocProvider.of<EditChapterBloc>(context).add(
                              EditOneChapterEvent(
                                  PreferenceUtils.getString("image")!,
                                  createChapterDto,
                                  idCapitulo));
                          Navigator.pushNamed(context, '/');
                        }
                      }
                    },
                    child: Text("Guardar",
                        style: BlookStyle.textCustom(
                            BlookStyle.whiteColor, BlookStyle.textSizeThree))),
              )
            ],
          ),
        ),
      ]),
    );
  }

  AwesomeDialog _createDialogC(context) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Error',
      desc: 'Debe seleccionar un archivo en formato pdf',
      btnOkText: "Aceptar",
      dialogBackgroundColor: BlookStyle.quaternaryColor,
      btnOkColor: BlookStyle.primaryColor,
      titleTextStyle:
          BlookStyle.textCustom(BlookStyle.whiteColor, BlookStyle.textSizeFour),
      descTextStyle: BlookStyle.textCustom(
          BlookStyle.whiteColor, BlookStyle.textSizeThree),
      btnOkOnPress: () {},
    )..show();
  }
}
