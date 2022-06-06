class CommentExistsResponse {
  CommentExistsResponse({
    required this.commentexist,
  });
  late final bool commentexist;
  
  CommentExistsResponse.fromJson(Map<String, dynamic> json){
    commentexist = json['commentexist'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['commentexist'] = commentexist;
    return _data;
  }
}