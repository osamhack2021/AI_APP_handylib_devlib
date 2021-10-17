import 'dart:convert';

import 'package:app/constants/uri.dart';
import 'package:app/controller/timestamp_convert.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:http/http.dart' as http;

class Comment {
  final String? content, author;
  final String? timeStamp;

  Comment(this.content, this.author, this.timeStamp);

  
  Comment.fromJson(Map<dynamic, dynamic> json)
      : content = json['content'],
        author = json['user_id'],
        timeStamp =  readTimestamp(parseTimestamp(json["time_stamp"]));

}

Comment defaultComment() {
  return Comment('test comment content', 'author', '2000-01-02');
}

Future<int> writeComment(
  String content,
  int postNumber,
  String tag,
  String userId,
) async {
  final response = await http.post(
    Uri.parse(proxyUri +
        myUri +
        'board/page/${postNumber}/comment_write?user_id=${userId}&tag=$tag'),
        //  POST /board/page/<number>/comment_write?user_id=xxx&tag=xxx
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'content': content,
      'number': postNumber,
      //'tag': tag,
      //'user_id': userId,
    }),
  );
  return response.statusCode;
}
