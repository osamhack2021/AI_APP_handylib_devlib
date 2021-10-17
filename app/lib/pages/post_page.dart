import 'package:app/components/custom_text_form_field.dart';
import 'package:app/components/default_circle_avatar.dart';
import 'package:app/components/error_notifier.dart';
import 'package:app/constants/colors.dart';
import 'package:app/constants/size.dart';
import 'package:app/models/comment_models.dart';
import 'package:app/models/post_models.dart';
import 'package:app/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  List<Comment>? _curPostList;

  @override
  Widget build(BuildContext context) {
    Future<Post> _getPostInfo(String tag, int postNumber) async {
      return await getPost(tag, postNumber);
      //return defaultPost();
    }

    Future<void> _renewCommnetList(String tag, int postNumber) async {
      setState(() async{
        _curPostList = (await getPost(tag, postNumber)).postCommentList;
      });
    }

    if (ModalRoute.of(context)!.settings.arguments == null) {
      return Scaffold(
        body: ErrorNotifier(
          errorMessage: '게시글 정보를 불러오지 못했어요. 앱을 다시 실행해주세요.',
        ),
      );
    }

    final thisPost = ModalRoute.of(context)!.settings.arguments as Post;

    if (myUser == null) {
      return Scaffold(
        body: ErrorNotifier(
          errorMessage: '유저 정보를 불러오지 못했어요. 앱을 다시 실행해주세요.',
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(COLOR_PRIMARY),
        // title: Text(_thisBoard.boardName!,
        // style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        children: [
          //Author Profile
          Card(
            margin: EdgeInsets.all(1.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                SizedBox(width: small_gap),
                DefaultCircleAvatar(size: 20),
                SizedBox(width: large_gap),
                Column(
                  children: [
                    Text('${thisPost.author}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          overflow: TextOverflow.clip,
                        )),
                    Text('${thisPost.timestamp}'),
                  ],
                )
              ]),
            ),
          ),
          //
          //Post Content
          Card(
              //Content
              margin: EdgeInsets.all(1.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(
                      '${thisPost.postName}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${thisPost.content}',
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    )
                  ]),
                ]),
              )),

          //Comments
          FutureBuilder<Post>(
            future: _getPostInfo(thisPost.postTag!, thisPost.postId!),
            builder: (BuildContext context, curPost) {
              if (curPost.hasData) {
                _curPostList = curPost.data!.postCommentList;
                return Column(
                  children: <Widget>[
                    for (Comment curComment in _curPostList!)
                      _SingleComment(curComment)
                  ],
                );
              } else if (curPost.hasError) {
                return ErrorNotifier(errorMessage: '댓글 목록을 불러오지 못했어요.');
              } else {
                return Column(children: [
                  SizedBox(
                    child: CircularProgressIndicator(),
                    width: 60,
                    height: 60,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('로딩 중입니다...'),
                  )
                ]);
              }
            },
          )
        ],
      ),
      bottomNavigationBar: CommentBottomBar(
          thisPost: thisPost,
          author: myUser!.userId,
          callback: _renewCommnetList),
    );
  }
}

class CommentBottomBar extends StatelessWidget {
  TextEditingController _commentController = TextEditingController();

  final Post thisPost;
  final String author;
  final Function? callback;

  CommentBottomBar(
      {required this.thisPost, required this.author, this.callback});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: (Row(
        children: [
          Expanded(
            child: TextFormField(
                controller: _commentController,
                decoration: InputDecoration(
                  hintText: '댓글을 입력하세요.',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                )),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () async {
              int _res = await writeComment(
                _commentController.value.text,
                thisPost.postId!,
                thisPost.postTag!,
                author,
              );
              _commentController.clear();
              await callback!(thisPost.postTag, thisPost.postId);
            },
          )
        ],
      )),
    );
  }
}

class _SingleComment extends StatelessWidget {
  final Comment thisComment;

  const _SingleComment(this.thisComment);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(1.0),
        child: ListTile(
            leading: DefaultCircleAvatar(size: 14),
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('${thisComment.author}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [Text('${thisComment.content}')],
                ),
              ],
            )));

    //Comment input form field
  }
}
