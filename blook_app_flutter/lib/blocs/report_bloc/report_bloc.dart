import 'package:bloc/bloc.dart';
import 'package:blook_app_flutter/models/create_report.dart';
import 'package:blook_app_flutter/models/report.dart';
import 'package:blook_app_flutter/repository/report_repository/report_repository.dart';
import 'package:equatable/equatable.dart';

import '../../models/error_response.dart';

part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final ReportRepository reportRepository;

  ReportBloc(this.reportRepository) : super(ReportInitial()) {
    on<DoReportEvent>(_doReportEvent);
  }

  void _doReportEvent(DoReportEvent event, Emitter<ReportState> emit) async {
    try {
      final reportResponse = await reportRepository.createReport(event.report);

      emit(ReportSuccessState(reportResponse));
      return;
    } on ErrorResponse catch (e) {
      emit(ReportErrorState(e));
    }
  }
}
