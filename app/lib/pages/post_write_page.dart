import 'package:app/components/custom_text_form_field.dart';
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

    final Board _thisBoard = ModalRoute.of(context)!.settings.arguments as Board; 
  
    return Scaffold(
      appBar : AppBar(
        backgroundColor: Color(COLOR_PRIMARY),
      ),
      body : ListView(
        children: [
          Card(
            child:CustomTextFormField(title : 'postTitle',controller:_postTitleController, hintText: '제목',),
          ),
          Card(child:
            TextFormField(
              controller: _postContentController,
              minLines:15,
              maxLines: 15,
            ),
          ),
            ElevatedButton(
              onPressed: (
              ) async {
                int res = await writePost(
                  _postContentController.value.text,
                  _postTitleController.value.text,
                  _thisBoard.boardTag!,
                  myUser!.userId
                );
                if(res == 200) {
                  final _snackbar =
                      SnackBar(content: Text('글을 등록했습니다.'));
                  ScaffoldMessenger.of(context).showSnackBar(_snackbar);
                  Navigator.pop(context);
                }
                else {
                  final _snackbar =
                      SnackBar(content: Text('글을 등록하지 못했습니다. 에러코드 : ${res}'));
                  ScaffoldMessenger.of(context).showSnackBar(_snackbar);
                  Navigator.pop(context);
                }
              },
              child: Text('글쓰기'),
            )
          ]
        )
      );
  }
}