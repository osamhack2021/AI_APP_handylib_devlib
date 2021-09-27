import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<User> createUser(String name, String id, String password) async{
    final response = await http.post(
      Uri.parse(''),
      headers: <String, String>{
        'Content-Type' : 'application.json charset=UTF-8',
      },
      body : jsonEncode(<String, String>{
        'name' : name,
        'user_id' : id,
        'password' : password,
      }),
    );
    
    if(response.statusCode ==201) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('계정을 생성하는 데 실패했습니다.');
    }
}

class User{
  final String? username;
  final String? id;
  final String? password;

  User(this.username, this.id, this.password);

  User.fromJson(Map<String, dynamic> json)
  : id = json["id"],
    username = json["username"],
    password = json["password"];
}