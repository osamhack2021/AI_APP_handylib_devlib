import 'package:app/constants/colors.dart';
import 'package:app/models/board_models.dart';
import 'package:app/pages/contest_page.dart';
import 'package:app/pages/forum_page.dart';
import 'package:flutter/material.dart';

class ForumScreen extends StatefulWidget {
  const ForumScreen({Key? key}) : super(key: key);

  @override
  _ForumScreenState createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListView(
        children: [
          ListTile(
            title:Text("게시판 목록"),
            tileColor: Color(COLOR_PRIMARY2),
          ),
          Card( child:
            ListTile(
              title:Text("hello"),
              trailing:(
                Icon(Icons.chevron_right)
              ),
            )
          )
          ],
      )
    );

  }
}
