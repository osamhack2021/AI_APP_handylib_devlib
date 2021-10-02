import 'package:flutter/material.dart';

class Board {
  int? boardId;
  String? boardName;

  Board(int myBoardId, String myBoardName){
    this.boardId = myBoardId;
    this.boardName = myBoardName;
  }
}

List<Board> boardDataList = [
  new Board(1, "대회 개최 게시판"),
  new Board(2, "독서 토론 게시판"),
  new Board(3, "자유게시판"),
];

List<Widget> boardWidgetList() {
  List<Widget> boards = [];
  for(Board thisBoard in boardDataList) {
    boards.add(
      ListTile(
        title:Text('${thisBoard.boardName}'),
      ),
    );
  }
  return boards;
}