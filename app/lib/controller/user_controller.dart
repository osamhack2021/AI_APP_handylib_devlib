import 'dart:async';
import 'dart:convert';
import 'package:app/constants/size.dart';
import 'package:app/constants/uri.dart';
import 'package:app/controller/message_controller.dart';
import 'package:app/screens/home_screen.dart';
import 'package:crypt/crypt.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

List<String> rankList = [
  "이병",
  "이등병",
  "일병",
  "상병",
  "병장",
  "하사",
  "중사",
  "상사",
  "원사",
  "소위",
  "중위",
  "대위",
  "소령",
  "중령",
  "대령",
  "준장",
  "소장",
  "중장",
  "대장",
  "군무원",
  "test"
];

Future<int> createUser(
  String name,
  String userId,
  String password,
  String email,
  String unit,
  String rank,
) async {
  final encryptedPassword = Crypt.sha256(password, salt: mySalt).toString();

  final response = await http.post(
    Uri.parse(proxyUri + myUri + 'sign_up/'),
    headers: <String, String>{
      //"Accept":"application/json",
      //"Access-Control-Allow-Origin":"*",W
      'Content-Type': 'application/json; charset=UTF-8',
    },
    /*headers: {
      },*/
    body: jsonEncode(<String, String>{
      'name': name,
      'user_id': userId,
      'password': encryptedPassword,
      'email': email,
      'unit': unit,
      'rank': rank,
    }),
  );
  debugPrint("responseBody: ${response.body}");
  if (response.statusCode == 200) {
    return response.statusCode;
  } else {
    return response.statusCode;
  }
}

void testHttp() async {
  final response = await http.get(
    Uri.parse(proxyUri + myUri + 'mypage/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  var statusCode = response.statusCode;
  var responseHeaders = response.headers;
  var responseBody = response.body;

  debugPrint("statusCode: ${statusCode}");
  debugPrint("responseHeaders: ${responseHeaders}");
  debugPrint("responseBody: ${responseBody}");
}

Future<int> loginUser(String userId, String password) async {
  final encryptedPassword = Crypt.sha256(password, salt: mySalt).toString();
  debugPrint(encryptedPassword + " " + password);
  final response = await http.post(
    Uri.parse(proxyUri + myUri + 'sign_in/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
      <String, String>{
        'user_id': userId,
        'password': encryptedPassword,
      },
    ),
  );

  //Message responseMessage = Message.fromJson(jsonDecode(response.body));

  return response.statusCode;
  /*
  if(responseMessage.message == "login success") {
    return true;
  }
  else {
    return false;
    */
}

String? getPropertyTitle(User myUser, String prop) {
  if (prop == 'name') return '이름';
  if (prop == 'userId') return '아이디';
  if (prop == 'password') return '비밀번호';
  if (prop == 'email') return '이메일';
  if (prop == 'unit') return '소속 부대';
  if (prop == 'rank') return '계급';
}

String? getPropertyValue(User myUser, String prop) {
  if (prop == 'name') return myUser.username;
  if (prop == 'userId') return myUser.userId;
  if (prop == 'password') return myUser.password;
  if (prop == 'email') return myUser.email;
  if (prop == 'unit') return myUser.unit;
  if (prop == 'rank') return myUser.rank;
}

Future<User> loadUserInfo(String userId) async {
  final response = await http.get(
    Uri.parse(proxyUri + myUri + 'info/' + '?user_id=${userId}'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  } else {
    throw Exception('Failed to load User data');
  }
}

Future<int> modifyUserInfo(User myUser) async {
  String _userId = myUser.userId;
  final response = await http.put(
    Uri.parse(proxyUri + myUri + 'info/edit?user_id=$_userId'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': myUser.username,
      'user_id': myUser.userId,
      'password': myUser.password,
      'email': myUser.email,
      'unit': myUser.unit,
      'rank': myUser.rank,
    }),
  );

  return response.statusCode;
}

class User {
  String username = "defaultName";
  String userId = "defaultUserId";
  String password = "defaultPassword";
  String email = "defaultEmail";
  String unit = "defaultUnit";
  String rank = "defaultRank";

  User(this.username, this.userId, this.password, this.email, this.unit,
      this.rank);

  User.fromJson(Map<String, dynamic> json)
      : userId = json["user_id"],
        username = json["name"],
        password = json["password"],
        email = json["email"],
        unit = json["unit"],
        rank = json["rank"];
}

User userCopy(User fromUser) {
  User newUser = User(
    fromUser.username,
    fromUser.userId,
    fromUser.password,
    fromUser.email,
    fromUser.unit,
    fromUser.rank,
  );
  return newUser;
}
