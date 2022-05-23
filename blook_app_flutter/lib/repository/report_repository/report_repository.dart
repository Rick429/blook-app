import 'package:blook_app_flutter/models/create_report.dart';
import 'package:blook_app_flutter/models/report.dart';

abstract class ReportRepository {
  
  Future<Report> createReport(CreateReport createReport);

}
