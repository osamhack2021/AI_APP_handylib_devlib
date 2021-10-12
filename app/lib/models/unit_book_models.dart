import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app/constants/uri.dart';
/*
class UnitBook {
  final String title, pubDate, tag;
  final int isbn, bookId;

  UnitBook(this.title, this.pubDate, this.tag, this.isbn, this.bookId);
  
  UnitBook.fromJson(Map<String, dynamic> json)
  : isbn = json["isbn"],
    title = json["title"],
    pubDate = json["publication_date"],
    tag = json["tag"],
    bookId = json["bookId"];

  
}*/

class UnitBook {
  final String title;
  final String author;
  final String pubDate;
  final String description;
  final int isbn13;
  final String coverUrl;
  final String publisher;
  final String category;

  UnitBook(this.title, this.author, this.pubDate, this.description, this.isbn13,
      this.coverUrl, this.publisher, this.category);

  UnitBook.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        author = json['author'],
        pubDate = json['pubDate'],
        description = json['description'],
        isbn13 = int.parse(json['isbn13']),
        coverUrl = json['cover'],
        publisher = json['publisher'],
        category = json['categoryName'];
}

List<UnitBook> getUnitBookList_test() {
  List<UnitBook> myUnitBookList = [];
  UnitBook myUnitBook = UnitBook('text book title', 'author', '2000-01-01', 'book description', 123456789, 'url', 'publisher', 'category');
  for(int i = 1; i <= 10; i++) {
    myUnitBookList.add(myUnitBook);
  }
  return myUnitBookList;
}

List<UnitBook> parseUnitBook(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String,dynamic>>();
  return parsed.map<UnitBook>((json)=>UnitBook.fromJson(json)).toList();
}

Future<List<UnitBook>> getUnitBookList(String unit) async {
  final response = await http.post(
      Uri.parse(proxyUri +  myUri + 'unit/' + unit),
      headers: <String, String>{
        'Content-Type' : 'application/json; charset=UTF-8',
      },
      body : jsonEncode(<String, String>{
        'Unit_name' : unit,
      },
    ),
  );
  return parseUnitBook(response.body);
}

