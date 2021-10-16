import 'dart:convert';

import 'package:app/constants/uri.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:http/http.dart' as http;

class Comment {
  String? content, author;
  Timestamp? timeStamp;

  Comment.fromJson(Map<dynamic, dynamic> json)
      : content = json['content'],
        author = json['user_id'],
        timeStamp = json['time_stamp'];
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
        'board/page/${postNumber}/comment_write?user_id=${userId}'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'content': content,
      'number': postNumber,
      'tag': tag,
      'user_id': userId,
    }),
  );
  return response.statusCode;
}
