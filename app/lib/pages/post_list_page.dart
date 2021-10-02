import 'package:app/components/forum_page/post_selector.dart';
import 'package:app/constants/colors.dart';
import 'package:app/constants/size.dart';
import 'package:app/models/board_models.dart';
import 'package:flutter/material.dart';

class PostListPage extends StatefulWidget {
  const PostListPage({ Key? key }) : super(key: key);

  @override
  State<PostListPage> createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  @override
  Widget build(BuildContext context) {

    final thisBoard = ModalRoute.of(context)!.settings.arguments as Board;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(COLOR_PRIMARY),
        title : 
          Text("${thisBoard.boardName}")
        
      ),
      body: (
        ListView(children:[
          for(int i = 1; i <= 10; i++) 
            PostSelector(1, "게시글 이름", "작성자"),
          AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Color(COLOR_PRIMARY2),
            leading: IconButton(
              onPressed: (){},
              icon: Icon(
                Icons.home,
                color: Colors.black,
                ),
            ),
            actions:<Widget>[
              IconButton(
                onPressed: (){},
                icon: Icon(
                  Icons.create,
                  color: Colors.black,
                ),
              )
            ]
          ),
        ]
        )
      ),
    );
  }
}