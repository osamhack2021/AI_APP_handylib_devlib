import 'package:app/components/custom_text_form_field.dart';
import 'package:app/components/default_circle_avatar.dart';
import 'package:app/constants/colors.dart';
import 'package:app/constants/size.dart';
import 'package:app/models/post_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PostPage extends StatelessWidget {
  const PostPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final thisPost = ModalRoute.of(context)!.settings.arguments as Post;
    
    return Scaffold(
      appBar:AppBar(
        backgroundColor : Color(COLOR_PRIMARY),
      ),
      body : ListView(
        children:[
          //Author Profile
          Card(
            margin : EdgeInsets.all(1.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children:[
                  SizedBox(width: small_gap),
                  DefaultCircleAvatar(size:20),
                  SizedBox(width:large_gap),
                  Column(children: [
                    Text(
                      '${thisPost.author}',
                      style:TextStyle(
                        fontWeight:FontWeight.bold,
                        fontSize:16,
                        overflow:TextOverflow.clip,
                      ) 
                    ),
                    Text('time'),
                  ],)
                ]
              ),
            ),
          ),
          //
          //Post Content
          Card(  //Content
            margin : EdgeInsets.all(1.0),
            child:
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children:[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${thisPost.postName}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:[
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
                    ]
                  ),
                ]
              ),
            )
          ),
          Column(children: 
                    List<Widget>.generate(
                      10, //(thisPost.postCommentList).length,
                      (index) => _SingleComment()
                    ),
          ),
          
        ],
      ),

      bottomNavigationBar: CommentBottomBar(),
      
    );
  }
}

class CommentBottomBar extends StatelessWidget {
  const CommentBottomBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar( child: (
      Row(children: [
          Expanded(child: 
          TextFormField(
            //controller: ,
            decoration: InputDecoration(
              hintText: '댓글을 입력하세요.', 
              contentPadding: EdgeInsets.fromLTRB(20.0,5.0,20.0,5.0),
            )
          ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: (){},
          )
        ],
      )
    ),

    );
  }
}


class _SingleComment extends StatelessWidget {
  const _SingleComment({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(1.0),
      child:ListTile(
        leading: DefaultCircleAvatar(size: 14),
        title: Column(

          children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Comment Author',
                style:TextStyle(
                  fontWeight:FontWeight.bold,
                )  
              ),
            ],
          ),

          Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),

        ],
        )
      )
    );
    
    //Comment input form field
    
  }
}