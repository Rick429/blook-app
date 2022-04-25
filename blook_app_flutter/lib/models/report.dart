class Report {
  Report({
    required this.id,
    required this.userId,
    required this.bookCommentId,
    required this.reportComment,
    required this.typeReport,
    required this.createdDate,
  });
  late final String id;
  late final String userId;
  late final String bookCommentId;
  late final String reportComment;
  late final String typeReport;
  late final String createdDate;
  
  Report.fromJson(Map<String, dynamic> json){
    id = json['id'];
    userId = json['user_id'];
    bookCommentId = json['book_comment_id'];
    reportComment = json['report_comment'];
    typeReport = json['type_report'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['user_id'] = userId;
    _data['book_comment_id'] = bookCommentId;
    _data['report_comment'] = reportComment;
    _data['type_report'] = typeReport;
    _data['created_date'] = createdDate;
    return _data;
  }
}