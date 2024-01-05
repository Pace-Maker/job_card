

class CommentSchema {

  // ==================================================================================================

  static const String findJobComment = '''
query findJobComment(\$commentId:Int){
  findJobComment(commentId: \$commentId){
    comment,
    commentTime,
    id,
    commentBy
  }
}
''';

// ==================================================================================================

  static const String findChecklistJobComment = '''
query findJobChecklistComment(\$commentId:Int){
  findJobChecklistComment(commentId: \$commentId){
    comment,
    commentTime,
    id,
    commentBy
  }
}
''';
  
}