class CreateReport {
  CreateReport({
    required this.reportComment,
    required this.typeReport,
  });
  late final String reportComment;
  late final String typeReport;
  
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['report_comment'] = reportComment;
    _data['type_report'] = typeReport;
    return _data;
  }
}