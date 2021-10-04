import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:xml/xml.dart';

Map<String, dynamic> aladinParam(String ISBN13) {
  Map<String, dynamic> ret = {
    "ttbkey": dotenv.env["TTBKEY"],
    "itemIdType": "ISBN13",
    "ItemId": ISBN13,
    "output": "XML",
    "Omitkey": "1",
    "Cover": "Big"
  };
  return ret;
}

Future<Map<String, dynamic>> api_get(
    Map<String, dynamic> _param, String _host, String _path) async {
  http.Response response = await http.get(
      Uri(scheme: "http", host: _host, path: _path, queryParameters: _param),
      headers: {"Accept": "application/json"});
  Map<String, dynamic> res;
  if (_host == "www.aladin.co.kr") {
    String body = response.body;
    final document = XmlDocument.parse(body);
    res = {
      "title": document.findAllElements("title").toList()[1].text,
      "author": document.findAllElements("author").toList()[0].text,
      "pubDate": document.findAllElements("pubDate").toList()[0].text,
      "cover": document.findAllElements("cover").toList()[0].text,
      "isbn13": document.findAllElements("isbn13").toList()[0].text,
      "publisher": document.findAllElements("publisher").toList()[0].text,
      "categoryName": document.findAllElements("categoryName").toList()[0].text,
      "description": document.findAllElements("description").toList()[0].text,
    };
  } else {
    res = jsonDecode(response.body);
  }

  return res;
}
// Map<String, dynamic> param = {
//   "ttbkey": "ttbmj2000go2316005",
//   "itemIdType": "ISBN13",
//   "ItemId": "9788901252438",
//   "output": "JS",
//   "Omitkey": "1"
// };

// http.Response response = await http.get(
//     Uri(
//         scheme: "http",
//         host: "www.aladin.co.kr",
//         path: "ttb/api/ItemLookUp.aspx",
//         queryParameters: param),
//     headers: {"Accept": "application/json"});
// Map<String, dynamic> responseBodyMap =
//     jsonDecode(response.body.substring(0, response.body.length - 1));
// print(responseBodyMap["version"]); // 결과 출력 ==> get
