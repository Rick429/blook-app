import 'package:blook_app_flutter/blocs/report_bloc/report_bloc.dart';
import 'package:blook_app_flutter/models/create_report.dart';
import 'package:blook_app_flutter/repository/report_repository/report_repository.dart';
import 'package:blook_app_flutter/repository/report_repository/report_repository_impl.dart';
import 'package:blook_app_flutter/ui/menu_screen.dart';
import 'package:blook_app_flutter/utils/preferences.dart';
import 'package:blook_app_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController commentController = TextEditingController();
  late ReportRepository reportRepository;

  @override
  void initState() {
    PreferenceUtils.init();
    reportRepository = ReportRepositoryImpl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          return ReportBloc(reportRepository);
        },
        child: _createBody(context));
  }

   Widget _createBody(BuildContext context) {
    return Scaffold(
       appBar:  AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Center(
          child: Container(
            margin: const EdgeInsets.only(right: 60),
            child: Text(
              "REPORTAR",
              style: BlookStyle.textCustom(
                  BlookStyle.whiteColor, BlookStyle.textSizeFive),
            ),
          ),
        ),
      ),
      backgroundColor: BlookStyle.blackColor,
      body: Center(
        child: Container(
            padding: const EdgeInsets.all(20),
            child: BlocConsumer<ReportBloc, ReportState>(
                listenWhen: (context, state) {
              return state is ReportSuccessState || state is ReportErrorState;
            }, listener: (context, state) {
              if (state is ReportSuccessState) {
                
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MenuScreen()),
                );
              } else if (state is ReportErrorState) {
                _showSnackbar(context, state.message);
              }
            }, buildWhen: (context, state) {
              return state is ReportInitial || state is ReportLoadingState;
            }, builder: (ctx, state) {
              if (state is ReportInitial) {
                return _createForm(ctx);
              } else if (state is ReportLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return _createForm(ctx);
              }
            })),
      ),
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _createForm(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [             
                    Container(
                      padding: const EdgeInsets.all(8),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        "Envía tus comentarios",
                        style: BlookStyle.textCustom(
                            BlookStyle.whiteColor, BlookStyle.textSizeThree),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(8),
                      child: TextFormField(
                        style: BlookStyle.textCustom(
                            BlookStyle.whiteColor, BlookStyle.textSizeTwo),
                        controller: commentController,
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: BlookStyle.blackColor,
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: BlookStyle.formColor, width: 5.0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: BlookStyle.formColor,
                              width: 2.0,
                            ),
                          ),
                          hintMaxLines: 10,
                          hintStyle: BlookStyle.textCustom(
                              BlookStyle.formColor, BlookStyle.textSizeTwo),
                          hintText:
                              '¿Quieres reportar un error? Escribelo \nRecuerda no incluir datos sensibles',
                        ),
                        onSaved: (String? value) {},
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.fromLTRB(10, 100, 10, 8),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: BlookStyle.primaryColor,
                          elevation: 15.0,
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                          final createReport = CreateReport(
                              reportComment: commentController.text, typeReport: PreferenceUtils.getString('typereport')!);
                          BlocProvider.of<ReportBloc>(context)
                              .add(DoReportEvent(createReport));
                        } 
                          Navigator.pushNamed(context, '/');
                        },
                        child: Text("Enviar",
                            style: BlookStyle.textCustom(BlookStyle.whiteColor,
                                BlookStyle.textSizeThree))),
                  )
            ],
          ),
        
      ),
    );
  }
}
