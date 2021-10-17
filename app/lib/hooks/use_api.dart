import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:xml/xml.dart';
import 'package:intl/intl.dart';

String aladinHost = "www.aladin.co.kr";
const String proxyUri = '';
String aladinFeedPath = "ttb/api/ItemLookUp.aspx";
String aladinSearchPath = "ttb/api/ItemSearch.aspx";
String aladinCategoryPath = "ttb/api/ItemList.aspx";
String proxy = "http://175.210.134.48:5000/";
//https://cors-anywhere.herokuapp.com/

Map<String, String> _monthMap = {
  "Jan": "01",
  "Feb": "02",
  "Mar": "03",
  "Apr": "04",
  "May": "05",
  "Jun": "06",
  "Jul": "07",
  "Aug": "08",
  "Sep": "09",
  "Oct": "10",
  "Nov": "11",
  "Dec": "12"
};

///////////////////// search //////////////////////
Map<String, dynamic> _aladinSearchParam(String query, int page) {
  Map<String, dynamic> ret = {
    "ttbkey": dotenv.env["TTBKEY"],
    "query": query,
    "output": "js",
    "start": page.toString(),
    "maxresults": "10",
    "Version": "20131101",
    "Cover": "Big"
  };
  return ret;
}

Future<Map<String, dynamic>> searchAladinApiGet(String query, int page) async {
  Map<String, dynamic> _param = _aladinSearchParam(query, page);

  http.Response response = await http.get(
      Uri.parse(proxy +
          Uri(
                  scheme: "http",
                  host: aladinHost,
                  path: aladinSearchPath,
                  queryParameters: _param)
              .toString()),
      headers: {"Accept": "application/json"});
  return jsonDecode(response.body);
}

///////////////////// search //////////////////////
///////////////////// feed //////////////////////

Map<String, dynamic> _aladinFeedParam(String isbn13) {
  Map<String, dynamic> ret = {
    "ttbkey": dotenv.env["TTBKEY"],
    "itemIdType": "ISBN13",
    "ItemId": isbn13,
    "output": "XML",
    "Omitkey": "1",
    "Cover": "Big"
  };
  return ret;
}

Future<Map<String, dynamic>> feedAladinApiGet(String isbn13) async {
  Map<String, dynamic> _param = _aladinFeedParam(isbn13);

  http.Response response = await http.get(
      Uri.parse(proxy +
          Uri(
                  scheme: "http",
                  host: aladinHost,
                  path: aladinFeedPath,
                  queryParameters: _param)
              .toString()),
      headers: {});
  Map<String, dynamic> res;
  String body = response.body;
  final document = XmlDocument.parse(body);
  List<String> t =
      document.findAllElements("pubDate").toList()[1].text.split(" ");
  String formatDateTime = DateFormat.yMMMd("ko_KR")
      .format(DateTime.parse(t[3] + "-" + _monthMap[t[2]]! + "-" + t[1]));

  res = {
    "title": document.findAllElements("title").toList()[1].text,
    "author": document.findAllElements("author").toList()[0].text,
    "pubDate": formatDateTime,
    "cover": document.findAllElements("cover").toList()[0].text,
    "isbn13": document.findAllElements("isbn13").toList()[0].text,
    "isbn": document.findAllElements("isbn").toList()[0].text,
    "publisher": document.findAllElements("publisher").toList()[0].text,
    "categoryName": document.findAllElements("categoryName").toList()[0].text,
    "description": document
        .findAllElements("description")
        .toList()[0]
        .text
        .replaceAllMapped(RegExp('(&lt;)|(&gt;)|(<.+?\/>)'),
            (Match m) => ""), //(&lt;)|(&gt;)|(<.+?\/>)
  };
  return res;
}

///////////////////// feed //////////////////////
///
Map<String, dynamic> _aladinCategoryParam(int categoryNum, int page) {
  Map<String, dynamic> ret = {
    "ttbkey": dotenv.env["TTBKEY"],
    "QueryType": "Bestseller",
    "MaxResults": "10",
    "output": "js",
    "start": page.toString(),
    "SearchTarget": "Book",
    "Version": "20131101",
    "Cover": "Big",
    "CategoryId": categoryNum.toString()
  };
  return ret;
}

Future<Map<String, dynamic>> feedAladinCategoryApi(
    int categoryNum, int page) async {
  Map<String, dynamic> _param = _aladinCategoryParam(categoryNum, page);

  http.Response response = await http.get(
      Uri.parse(proxy +
          Uri(
                  scheme: "http",
                  host: aladinHost,
                  path: aladinCategoryPath,
                  queryParameters: _param)
              .toString()),
      headers: {"Accept": "application/json"});
  return jsonDecode(response.body);
}

///////////////// detailpage sync //////////////////////
const String myUri = 'https://www.projectlib.tk';
// const String myUri = 'http://175.210.134.48:3000/';

Future<Map<String, dynamic>> getUnitBookInfo(String unit, String isbn) async {
  const path = "/unit/chk/";
  http.Response response = await http.get(
      Uri.parse(myUri + path + "Unit_name=${unit}&isbn=${isbn}"),
      headers: {"Accept": "application/json"});
  return jsonDecode(utf8.decode(response.bodyBytes));
}

Future<int> borrowUnitBook(String unit, String isbn, String userId) async {
  const path = "/unit/brr/";
  http.Response response = await http.post(
      Uri.parse(
          myUri + path + "Unit_name=${unit}&isbn=${isbn}&user_id=${userId}"),
      headers: {"Accept": "application/json"});
  return response.statusCode;
}

Future<int> returnUnitBook(String unit, String isbn, String userId) async {
  const path = "/unit/ret/";
  http.Response response = await http.post(
      Uri.parse(
          myUri + path + "Unit_name=${unit}&isbn=${isbn}&user_id=${userId}"),
      headers: {"Accept": "application/json"});
  return response.statusCode;
}
