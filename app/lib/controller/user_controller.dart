import 'dart:async';
import 'dart:convert';
import 'package:app/constants/uri.dart';
import 'package:crypt/crypt.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<User> createUser(
  String name, 
  String userId, 
  String password, 
  String email,
  String unit,
  String rank,
  ) async{

    final encryptedPassword = Crypt.sha256(password).toString();

    final response = await http.post(
      Uri.parse(proxyUri+ myUri+'sign_up'),
      headers: <String, String>{
        'Content-Type' : 'application/json; charset=UTF-8',
      },
      body : jsonEncode(<String, String>{
        'name' : name,
        'user_id' : userId,
        'password' : encryptedPassword,
        'email' : email,
        'unit' : unit,
        'rank' : rank,
      }),
    );
    debugPrint("responseBody: ${response.body}");
    if(response.statusCode ==200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('${response.statusCode} : 생성하는 데 실패했습니다.');
    }
}
/*
void  testHttp() async{
  final response = await http.get(
    Uri.parse(proxyUri+myUri+'mypage'),
   /* headers: <String, String>{
      'Content-Type' : 'application/json; charset=UTF-8',
    },*/
  );
  var statusCode = response.statusCode; 
  var responseHeaders = response.headers;
  var responseBody = response.body;

  debugPrint("statusCode: ${statusCode}");
  debugPrint("responseHeaders: ${responseHeaders}");
  debugPrint("responseBody: ${responseBody}");

}*/


bool loginUser(String userId, String password) {
  final response =  http.post(
      Uri.parse(''),
      headers: <String, String>{
        'Content-Type' : 'application/json; charset=UTF-8',
      },
      body : jsonEncode(<String, String>{
        'user_id' : userId,
        'password' : password,
      }),
    );
    
    return true; //Response 협의 후 수정 예정
}

String? getPropertyTitle(User myUser, String prop) {
    if(prop == 'username') return '이름';
    if(prop == 'userId') return '아이디';
    if(prop == 'password') return '비밀번호';
    if(prop == 'email') return '이메일';
    if(prop == 'unit') return '소속 부대';
    if(prop == 'rank') return '계급';
}

String? getPropertyValue(User myUser, String prop) {
    if(prop == 'username') return myUser.username;
    if(prop == 'userId') return myUser.userId;
    if(prop == 'password') return myUser.password;
    if(prop == 'email') return myUser.email;
    if(prop == 'unit') return myUser.unit;
    if(prop == 'rank') return myUser.rank;
}

Future<User> loadUserInfo(String userId) async {
  final response = await http.get(Uri.parse(myUri + ''));

  if(response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load User data');
  }
}

class User{
  final String? username;
  final String? userId;
  final String? password;
  final String? email;
  final String? unit;
  final String? rank;

  User(this.username, this.userId, this.password, this.email, this.unit, this.rank);

  User.fromJson(Map<String, dynamic> json)
  : userId = json["user_id"],
    username = json["username"],
    password = json["password"],
    email = json["email"],
    unit = json["unit"],
    rank = json["rank"];

}