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

class PostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        backgroundColor: Color(COLOR_PRIMARY),
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
          Column(
            children: List<Widget>.generate((thisPost.postCommentList).length,
                (index) => _SingleComment(thisPost.postCommentList[index])),
          ),
        ],
      ),
      bottomNavigationBar:
          CommentBottomBar(thisPost: thisPost, author: myUser!.userId),
    );
  }
}

class CommentBottomBar extends StatelessWidget {
  TextEditingController _commentController = TextEditingController();

  final Post thisPost;
  final String author;

  CommentBottomBar({required this.thisPost, required this.author});

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
            onPressed: () {
              writeComment(
                _commentController.value.text,
                thisPost.postId!,
                thisPost.postTag!,
                author,
              );
              _commentController.clear();
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
                    Text('Comment Author',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
                Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
              ],
            )));

    //Comment input form field
  }
}
