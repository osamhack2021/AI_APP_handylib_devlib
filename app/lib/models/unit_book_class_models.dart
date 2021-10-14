import 'package:app/models/unit_book_models.dart';

class UnitBookClass {
  String? tag, title;
  int? id;

  UnitBookClass(String myTag, String myTitle, int myId) {
    tag = myTag;
    title = myTitle;
    id =myId;
  }

  /*UnitBookClass.fromJson(Map<String, dynamic> json)
  : tag = json["user_id"],
    username = json["username"],
    password = json["password"],
    email = json["email"],
    unit = json["unit"],
    rank = json["rank"];*/
}

List<UnitBookClass> myUnitBookClassList = [
  UnitBookClass("popular", "우리 부대 인기 도서", 0),
  UnitBookClass("new", "새로 들어온 책", 1),
  UnitBookClass("total", "전체 책", 2),
  UnitBookClass("borrowed", "대출한 도서", 100),
];


String? getUnitBookClassTitlebyTag(String searchTag) {
  for(UnitBookClass cur in myUnitBookClassList) {
    if(cur.tag == searchTag) {
      return cur.title;
    }
  }
  return "알 수 없는 목록";
}