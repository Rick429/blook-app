import 'dart:convert';
import 'package:blook_app_flutter/models/create_report.dart';
import 'package:blook_app_flutter/models/error_response.dart';
import 'package:blook_app_flutter/models/login_response.dart';
import 'package:blook_app_flutter/models/report.dart';
import 'package:blook_app_flutter/repository/report_repository/report_repository.dart';
import 'package:blook_app_flutter/utils/preferences.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import '../../constants.dart';

 class ReportRepositoryImpl extends ReportRepository {
  final Client _client = Client();

  @override
  Future<Report> createReport(CreateReport createReport) async {

    var request = http.MultipartRequest(
      'POST', Uri.parse('${Constant.baseurl}report/${PreferenceUtils.getString('idbook')}'),);

      request.files.add(http.MultipartFile.fromString('report', jsonEncode(createReport.toJson()),
        contentType: MediaType('application', 'json'), filename: "report",
        )
        );
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer ${PreferenceUtils.getString('token')}' 
     
    };
     request.headers.addAll(headers);
    var res = await request.send();
    final respStr = await res.stream.bytesToString();
    if (res.statusCode == 201) {
      Report reportResponse = Report.fromJson(json.decode(respStr));
      return reportResponse;
    } else {
      final error = ErrorResponse.fromJson(json.decode(respStr));
      throw error;
    }
  }
  }