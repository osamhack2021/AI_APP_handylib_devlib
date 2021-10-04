import 'package:app/components/forum_page/board_selector.dart';
import 'package:app/constants/colors.dart';
import 'package:app/models/board_models.dart';
import 'package:flutter/material.dart';

class ForumScreen extends StatefulWidget {
  const ForumScreen({Key? key}) : super(key: key);

  @override
  _ForumScreenState createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(COLOR_PRIMARY),
        automaticallyImplyLeading: false,
        title:Center( child:
          Text("게시판")
        )
      ),
      body: 
      ListView(
        children: [
          ListTile(
            title:Text("   게시판 목록"),
            tileColor: Color(COLOR_PRIMARY2),
          ),
          for(Board myBoard in boardDataList)
            BoardSelector(myBoard.boardId),
          ],
      )
    );

  }
}
