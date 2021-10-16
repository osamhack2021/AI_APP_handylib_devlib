import 'package:app/components/error_notifier.dart';
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
    return await getPostListbyTag(tag!, 1);
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments == null) {
      return Scaffold(
        body: ErrorNotifier(
          errorMessage: '게시판 정보를 불러오지 못했어요. 앱을 다시 실행해주세요.',
        ),
      );
    }

    final thisBoard = ModalRoute.of(context)!.settings.arguments as Board;
    
    _getPostList(thisBoard.boardTag);
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
        body: FutureBuilder<List<Post>>(
          future: _getPostList(thisBoard.boardTag),
          builder: (BuildContext context, nowPostList) {
            List<Widget> children;
            if (nowPostList.hasData) {
              children = <Widget>[
                //ListView(children: [
                for (Post curPost in nowPostList.data!) PostSelector(curPost)
                //])
              ];
              return ListView(
                children: children,
              );
            } else if (nowPostList.hasError) {
              return ErrorNotifier(
                  errorMessage: '게시판 정보를 불러오지 못했어요. 잠시 후 다시 시도해주세요.');
            } else {
              children = const <Widget>[
                SizedBox(
                  child: CircularProgressIndicator(),
                  width: 60,
                  height: 60,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('게시판 정보를 불러오는 중입니다...'),
                )
              ];
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: children,
                ),
              );
            }
          },
        )
        /*
      (ListView(children: [
        for (Post curPost in nowPostList) PostSelector(curPost)
      ])),*/
        );
  }
}
