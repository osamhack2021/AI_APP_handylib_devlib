import 'package:app/models/post_models.dart';
import 'package:app/pages/post_list_page.dart';
import 'package:flutter/material.dart';



class PostSelector extends StatelessWidget {
  final int? postId;
  final String? postName, postAuthor;
  
  PostSelector(this.postId, this.postName, this.postAuthor);
  
  @override
  Widget build(BuildContext context) {    
    

    return Card( 
      margin:EdgeInsets.all(1.0),
      child:
      ListTile(
        onTap: (){
          //Navigator.of(context).pushNamed(
            
        },
        //dense:true,
        title:Text('${postName}'),
        subtitle: Text('$postAuthor'),
      )
    );
  }
}