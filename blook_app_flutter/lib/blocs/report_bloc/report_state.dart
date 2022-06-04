part of 'report_bloc.dart';

abstract class ReportState extends Equatable {
  const ReportState();
  
  @override
  List<Object> get props => [];
}

class ReportInitial extends ReportState {}

class ReportLoadingState extends ReportState {}

class ReportSuccessState extends ReportState {
  final Report reportResponse;

  const ReportSuccessState(this.reportResponse);

  @override
  List<Object> get props => [reportResponse];
}

class ReportErrorState extends ReportState {
  final ErrorResponse error;

  const ReportErrorState(this.error);

  @override
  List<Object> get props => [error];
}