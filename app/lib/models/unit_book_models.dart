import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
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
/* ///////////////////1012
class UnitBookList {
  final List<UnitBook> unitBooks;

  UnitBookList ({
    required this.unitBooks,
  });
}*/

class UnitBook {
  final String? title;
  final String? author;
  final String? pubDate;
  final String? description;
  final String? isbn13;
  final String? coverUrl;
  final String? publisher;
  final String? category;

  UnitBook(this.title, this.author, this.pubDate, this.description, this.isbn13,
      this.coverUrl, this.publisher, this.category);

  UnitBook.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        author = json['author'],
        pubDate = json['pubDate'],
        description = json['description'],
        isbn13 = json['isbn13'],
        coverUrl = json['cover'],
        publisher = json['publisher'],
        category = json['categoryName'];
}

UnitBook defaultUnitBookModel() {
  return UnitBook('text book title', 'author', '2000-01-01',
      'book description', '123456789', null, 'publisher', 'category');
}

List<UnitBook> getUnitBookList_test() {
  List<UnitBook> myUnitBookList = [];
  UnitBook myUnitBook = UnitBook('text book title', 'author', '2000-01-01',
      'book description', '123456789', null, 'publisher', 'category');
  for (int i = 1; i <= 10; i++) {
    myUnitBookList.add(myUnitBook);
  }
  return myUnitBookList;
}

List<UnitBook> parseUnitBook(dynamic decodedResponseBody) {
  //debugPrint(decodedResponseBody.toString());
  //debugPrint(decodedResponseBody['books_list'].toString());
  /*debugPrint((decodedResponseBody['books_list'] as List)
      .map((i) => UnitBook.fromJson(i))
      .toList().toString());*/
  return (decodedResponseBody['books_list'] as List)
      .map((i) => UnitBook.fromJson(i))
      .toList();
  /*return (json.decode(responseBody) as List)
      .map((i) => UnitBook.fromJson(i))
      .toList();*/

  /*
  final parsed = json.decode(responseBody).cast<Map<String,dynamic>>();
  return parsed.map<UnitBook>((json)=>UnitBook.fromJson(json)).toList();
  */
}

//부대 전체 책 리스트 가져오기
Future<List<UnitBook>> getUnitBookList(String unit) async {
  final response = await http.post(
    Uri.parse(proxyUri + myUri + 'unit/' + Uri.encodeComponent(unit)),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
      <String, String>{
        'Unit_name': unit,
      },
    ),
  );
  return parseUnitBook(jsonDecode(utf8.decode(response.bodyBytes)));
}
//User.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));

Future<List<UnitBook>> getUnitTagBookList(String unit, String tag) async {
  final response = await http.post(
    Uri.parse(proxyUri + myUri + 'unit/$tag/' + Uri.encodeComponent(unit)),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
      <String, String>{
        'Unit_name': unit,
      },
    ),
  );
  return parseUnitBook(jsonDecode(utf8.decode(response.bodyBytes)));
}