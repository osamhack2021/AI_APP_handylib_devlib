import 'comment_models.dart';

class Post {
  int? postId;
  String? postName, postTag, author, content, timeStamp;
  List<int> postCommentList = [];

  Post(
    int myPostId,
    String myPostName,
    String myauthor,
    String myPostTag,
    String mycontent,
  ) {
    postId = myPostId;
    postName = myPostName;
    author = myauthor;
    postTag = myPostTag;
    content = mycontent;
  }

  Post.fromJson(Map<String, dynamic> json)
      : postId = json["number"],
        author = json["user_id"],
        postName = json["title"],
        content = json["content"],
        postTag = json["tag"];
  //timeStamp = json["time_stamp"];

}
