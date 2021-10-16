import 'package:app/components/error_notifier.dart';
import 'package:app/constants/colors.dart';
import 'package:app/models/board_models.dart';
import 'package:app/models/post_models.dart';
import 'package:app/pages/post_list_page.dart';
import 'package:flutter/material.dart';

class BoardSelector extends StatelessWidget {
  final int? boardId;
  BoardSelector(this.boardId);

  List<Post> nowPostList = [];

  Future<List<Post>> _getPostList(String? tag) async {
    List<Post> _previewPosts = await getPostListbyTag(tag!, 1);
    _previewPosts = _previewPosts.sublist(0, 3);
    return _previewPosts;
  }

  @override
  Widget build(BuildContext context) {
    Board thisBoard = getBoardbyId(boardId);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Column(children: [
        TitleWithMoreBtnWidget(
            title: thisBoard.boardName!,
            onTap: () {
              Navigator.of(context).pushNamed(
                '/home/forum/post-list',
                arguments: thisBoard,
              );
            }),
        const Divider(
          color: Colors.black38,
          height: 10,
          thickness: 2.4,
          indent: 10,
          endIndent: 10,
        ),
        FutureBuilder<List<Post>>(
            future: _getPostList(thisBoard.boardTag),
            builder: (BuildContext context, nowPostList) {
              List<Widget> children;
              if (nowPostList.hasData) {
                children = <Widget>[
                  for (Post curPost in nowPostList.data!)
                    _PostPreviewTile(thisBoard: thisBoard, curPost: curPost)
                ];
              } else if (nowPostList.hasError) {

                return ErrorNotifier(errorMessage: '게시판 정보를 불러오지 못했어요. 나중에 다시 시도해주세요.');

              } else {
                children = const <Widget>[
                  SizedBox(
                    child: CircularProgressIndicator(),
                    width: 60,
                    height: 60,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),

                    child: Text('게시판을 불러오는 중입니다...'),
                  )
                ];
              }
              return Column(
                children: children,
              );
            })
        /*
        ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (BuildContext context, int j) {
              return ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    '/home/forum/post-list',
                    arguments: thisBoard,
                  );
                },
                //dense:true,
                title: Text('${thisBoard.boardName}'),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                color: Colors.black12,
                height: 0,
                thickness: 1,
                indent: 15,
                endIndent: 15,
              );
            })
            */
      ]),
      // ListTile(
      //   onTap: () {
      //     Navigator.of(context).pushNamed(
      //       '/home/forum/post-list',
      //       arguments: thisBoard,
      //     );
      //   },
      //   //dense:true,
      //   title: Text('${thisBoard.boardName}'),
      //   trailing: (const Icon(Icons.chevron_right)),
      // )
    );
  }
}


class _PostPreviewTile extends StatelessWidget {
  const _PostPreviewTile({
    Key? key,
    required this.thisBoard,
    required this.curPost,
  }) : super(key: key);

  final Board thisBoard;
  final Post curPost;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            Navigator.of(context).pushNamed(
              '/home/forum/post-list',
              arguments: thisBoard,
            );
          },
          title: Text('${curPost.postName}'),
        ),
        const Divider(
          color: Colors.black12,
          height: 0,
          thickness: 1,
          indent: 15,
          endIndent: 15,
        )
      ],
    );
  }
}

class TitleWithMoreBtnWidget extends StatelessWidget {
  TitleWithMoreBtnWidget({
    required this.title,
    required this.onTap,
  });

  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              height: 28,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: Text(
                      title,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ), // Text
                  ), // Padding
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                        margin: const EdgeInsets.only(right: 6),
                        height: 7,
                        decoration: BoxDecoration(
                            color: Color(COLOR_PRIMARY).withOpacity(0.2),
                            borderRadius:
                                BorderRadius.circular(10))), // Container
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          const Text("더보기"),
          const Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 5, 10),
            child: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}

/*
Route _createRouteBoardSelector() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const PostListPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

class SlideRightPostListPageRoute extends PageRouteBuilder {

SlideRightPostListPageRoute()
  : super(
      pageBuilder: (context, animation, secondaryAnimation) => const PostListPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
 );
}*/