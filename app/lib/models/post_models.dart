import 'comment_models.dart';

class Post {
  int? postId;
  String? postName, postTag, postAuthor, postContent;
  List<Comment> postCommentList = [];

  Post(
    int myPostId, 
    String myPostName,
    String myPostAuthor,
    String myPostTag,
    String myPostContent,
    ){
    postId = myPostId;
    postName = myPostName;
    postAuthor = myPostAuthor;
    postTag = myPostTag;
    postContent = myPostContent;
  }
}
