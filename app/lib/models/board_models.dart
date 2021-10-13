import 'dart:convert';
import 'dart:io';
import 'package:app/constants/uri.dart';
import 'package:app/models/post_models.dart';
import 'package:http/http.dart' as http;

class Board {
  int? boardId;
  String? boardName, boardTag;

  Board(int myBoardId, String myBoardName, String myBoardTag){
    boardId = myBoardId;
    boardName = myBoardName;
    boardTag = myBoardTag;
  }
}

List<Board> boardDataList = [
  Board(1, "대회 개최 정보", "contest"),
  Board(2, "독서 토론 게시판", "debate"),
  Board(3, "자유게시판", "free"),
];

List<Post> parsePost(dynamic decodedResponseBody) {
  return (decodedResponseBody as List)
      .map((i) => Post.fromJson(i))
      .toList();
}

Future<List<Post>> getPostListbyTag(String tag, int pageId) async {
  final _queryPatameters = {
    'tag' : tag,
    'page_id' : pageId,
  };

  
  final response = await http.get(
      Uri.parse(proxyUri +  myUri + 'board/$pageId?tag=$tag'),
      headers: <String, String>{
        'Content-Type' : 'application/json; charset=UTF-8',
      },
  );
  return parsePost(jsonDecode(utf8.decode(response.bodyBytes)));
}


getBoardbyId(int? boardIdQuery) {
  for(Board myBoard in boardDataList) {
    if(myBoard.boardId == boardIdQuery) {
      return myBoard;
    }
  } 
  throw Exception('Could not find the board by boardId');
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