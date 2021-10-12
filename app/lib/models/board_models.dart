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

List<Post> parsePost(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String,dynamic>>();
  return parsed.map<Post>((json)=>Post.fromJson(json)).toList();
}

Future<List<Post>> getPostListbyTag(String tag) async {
  final _queryPatameters = {
    'tag' : tag,
    'page_id' : 1,
  };

  final uri = Uri.http(proxyUri+ myUri, 'unit/', _queryPatameters);
  final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
  final response = await http.get(uri, headers:headers);
/*
  final response = await http.get(
      Uri.parse(proxyUri +  myUri + 'board/1'),
      headers: <String, String>{
        'Content-Type' : 'application/json; charset=UTF-8',
      },
  );*/
  return parsePost(response.body);
}


getBoardbyId(int? boardIdQuery) {
  for(Board myBoard in boardDataList) {
    if(myBoard.boardId == boardIdQuery) {
      return myBoard;
    }
  } 
  throw Exception('Could not find the board by boardId');
}