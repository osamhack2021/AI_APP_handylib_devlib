
import 'package:app/models/board_models.dart';
import 'package:app/pages/post_list_page.dart';
import 'package:flutter/material.dart';



class BoardSelector extends StatelessWidget {
  final int? boardId;
  
  BoardSelector(this.boardId);
  
  @override
  Widget build(BuildContext context) {    
    Board thisBoard = getBoardbyId(boardId);
    

    return Card( 
      margin : EdgeInsets.all(1.0),
      child:
      ListTile(
        onTap: (){
          Navigator.of(context).pushNamed(
            '/home/forum/post-list',
            arguments:thisBoard,
            );
        },
        //dense:true,
        title:Text('${thisBoard.boardName}'),
        trailing:(
          const Icon(Icons.chevron_right)
        ),
      )
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