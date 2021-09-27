import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Map<String, dynamic> aladinParam(String ISBN13) {
  Map<String, dynamic> ret = {
    "ttbkey": dotenv.env["TTBKEY"],
    "itemIdType": "ISBN13",
    "ItemId": ISBN13,
    "output": "JS",
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
    res = jsonDecode(response.body.substring(0, response.body.length - 1));
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
