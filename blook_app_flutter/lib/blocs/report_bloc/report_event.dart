part of 'report_bloc.dart';

abstract class ReportEvent extends Equatable {
  const ReportEvent();

  @override
  List<Object> get props => [];
}

class DoReportEvent extends ReportEvent {
  final CreateReport report;

  const DoReportEvent(this.report);
}