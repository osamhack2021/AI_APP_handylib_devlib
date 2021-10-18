import 'package:app/components/forum_page/board_selector.dart';
import 'package:app/components/titled_appbar.dart';
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
        appBar: TitledAppbar("게시판"),
        body: ListView(
          children: [
            for (Board myBoard in boardDataList) BoardSelector(myBoard.boardId),
          ],
        ));
  }
}
