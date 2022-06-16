class CreateCommentDto {
  CreateCommentDto({
    required this.comment
  });
  late final String comment;
  
  CreateCommentDto.fromJson(Map<String, dynamic> json){
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['comment'] = comment;
    return _data;
  }
}