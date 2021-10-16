import 'package:app/components/custom_text_form_field.dart';
import 'package:app/components/login_page/rounded_button.dart';
import 'package:app/constants/colors.dart';
import 'package:app/models/board_models.dart';
import 'package:app/models/post_models.dart';
import 'package:app/screens/home_screen.dart';
import 'package:flutter/material.dart';

class PostWritePage extends StatelessWidget {
  TextEditingController _postTitleController = TextEditingController();
  TextEditingController _postContentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Board _thisBoard =
        ModalRoute.of(context)!.settings.arguments as Board;

    return Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Color(COLOR_PRIMARY),
            title: Text(_thisBoard.boardName!,
                style: const TextStyle(fontWeight: FontWeight.bold))),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: ListView(children: [
            TextFormField(
              controller: _postTitleController,
              maxLength: 30,
              decoration: const InputDecoration(
                icon: Icon(Icons.article, color: Color(COLOR_PRIMARY)),
                labelText: '제목',
                labelStyle: TextStyle(
                  color: Color(COLOR_PRIMARY),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(COLOR_PRIMARY)),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: _postContentController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: '내용',
                labelText: '내용',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            RoundedButton(
                text: "글쓰기",
                press: () async {
                  int res = await writePost(
                      _postContentController.value.text,
                      _postTitleController.value.text,
                      _thisBoard.boardTag!,
                      myUser!.userId);
                  if (res == 200) {
                    final _snackbar = SnackBar(content: Text('글을 등록했습니다.'));
                    ScaffoldMessenger.of(context).showSnackBar(_snackbar);
                    Navigator.pop(context);
                  } else {
                    final _snackbar =
                        SnackBar(content: Text('글을 등록하지 못했습니다. 에러코드 : ${res}'));
                    ScaffoldMessenger.of(context).showSnackBar(_snackbar);
                    Navigator.pop(context);
                  }
                })
          ]),
        ));
  }
}
