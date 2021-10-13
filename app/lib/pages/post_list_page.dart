import 'package:app/components/forum_page/post_selector.dart';
import 'package:app/components/titled_appbar.dart';
import 'package:app/constants/colors.dart';
import 'package:app/constants/size.dart';
import 'package:app/models/board_models.dart';
import 'package:app/models/post_models.dart';
import 'package:flutter/material.dart';

class PostListPage extends StatefulWidget {
  const PostListPage({Key? key}) : super(key: key);

  @override
  State<PostListPage> createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  List<Post> nowPostList = [];

  Future<List<Post>> _getPostList(String? tag) async {
    //nowPostList = await getPostListbyTag(tag!, 1);
    return await getPostListbyTag(tag!, 1);
    //debugPrint(nowPostList.toString());
  }

  

  @override

  Widget build(BuildContext context) {
    final thisBoard = ModalRoute.of(context)!.settings.arguments as Board;

    
    debugPrint('in build ' + nowPostList.toString());
    return Scaffold(
      appBar: TitledAppbar(thisBoard.boardName!),
      bottomNavigationBar: BottomAppBar(
        color: Color(COLOR_PRIMARY2),
        child: Row(children: [
          IconButton(
            padding: EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.home,
              color: Colors.black54,
            ),
          ),
          Expanded(child: Row()),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                '/home/forum/post-list/write',
                arguments: thisBoard,
              );
            },
            icon: Icon(
              Icons.create,
              color: Colors.black54,
            ),
          )
        ]),
      ),
      body: (ListView(children: [
        /*for(int i = 1; i <= 10; i++) 
            PostSelector(Post(1, '게시글 $i', 'Author $i', 'tag', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum')),
          */
        for (Post curPost in nowPostList) PostSelector(curPost)
      ])),
    );
  }
}
