import 'package:app/models/post_models.dart';
import 'package:flutter/material.dart';

class PostSelector extends StatelessWidget {
  final Post _thisPost;

  const PostSelector(this._thisPost);
  
  
  @override
  Widget build(BuildContext context) {    
    

    return Card( 
      margin:EdgeInsets.all(1.0),
      child:
      ListTile(
        onTap: (){
          Navigator.of(context).pushNamed(
            '/home/forum/post-list/post',
            arguments:_thisPost,
          );
        },
        //dense:true,
        title:Text('${_thisPost.postName}'),
        subtitle: Text('작성자 : ${_thisPost.author}'),
      )
    );
  }
}