class Board {
  int? boardId;
  String? boardName;

  Board(int myBoardId, String myBoardName){
    boardId = myBoardId;
    boardName = myBoardName;
  }
}

List<Board> boardDataList = [
  Board(1, "대회 개최 정보"),
  Board(2, "독서 토론 게시판"),
  Board(3, "자유게시판"),
];

getBoardbyId(int? boardIdQuery) {
  for(Board myBoard in boardDataList) {
    if(myBoard.boardId == boardIdQuery) {
      return myBoard;
    }
  } 
  throw Exception('Could not find the board by boardId');
}