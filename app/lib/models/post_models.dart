import 'dart:convert';

import 'package:app/constants/uri.dart';
import 'package:app/controller/timestamp_convert.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:http/http.dart' as http;
import 'comment_models.dart';

class Post {
  int? postId;
  String? postName, postTag, author, content;
  String? timestamp;
  List<Comment> postCommentList = [];

  Post(
    int myPostId,
    String myPostName,
    String myauthor,
    String myPostTag,
    String mycontent,
  ) {
    postId = myPostId;
    postName = myPostName;
    author = myauthor;
    postTag = myPostTag;
    content = mycontent;
  }

  Post.fromJson(Map<String, dynamic> json)
      : postId = json["number"],
        author = json["user_id"],
        postName = json["title"],
        content = json["content"],
        postTag = json["tag"],
        postCommentList = parseComment(json["comment_list"]),
        timestamp = readTimestamp(parseTimestamp(json["time_stamp"]));
}

Future<int> writePost(
  String content,
  String title,
  String tag,
  String userId,
) async {
  final response = await http.post(
    Uri.parse(proxyUri + myUri + 'board/write' + '?user_id=${userId}'),
    headers: <String, String> {
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'content' : content,
      'title' : title,
      'tag' : tag,
      'user_id' : userId,
    }),
  );
  return response.statusCode;
}

List<Comment> parseComment(dynamic decodedResponseBody) {
  return (decodedResponseBody as List)
      .map((i) => Comment.fromJson(i))
      .toList();
}
