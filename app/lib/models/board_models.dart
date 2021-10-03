import 'package:app/models/post_models.dart';

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

getBoardbyId(int? boardIdQuery) {
  for(Board myBoard in boardDataList) {
    if(myBoard.boardId == boardIdQuery) {
      return myBoard;
    }
  } 
  throw Exception('Could not find the board by boardId');
}