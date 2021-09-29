import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<User> createUser(String name, String user_id, String password) async{
    final response = await http.post(
      Uri.parse(''),
      headers: <String, String>{
        'Content-Type' : 'application/json; charset=UTF-8',
      },
      body : jsonEncode(<String, String>{
        'name' : name,
        'user_id' : user_id,
        'password' : password,
      }),
    );
    
    if(response.statusCode ==201) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('계정을 생성하는 데 실패했습니다.');
    }
}

bool loginUser(String user_id, String password) {
  final response =  http.post(
      Uri.parse(''),
      headers: <String, String>{
        'Content-Type' : 'application/json; charset=UTF-8',
      },
      body : jsonEncode(<String, String>{
        'user_id' : user_id,
        'password' : password,
      }),
    );
    
    return true; //Response 협의 후 수정 예정
}

class User{
  final String? username;
  final String? user_id;
  final String? password;
  final String? email;
  final String? rank;
  final String? unit;

  User(this.username, this.user_id, this.password, this.email, this.rank, this.unit);

  User.fromJson(Map<String, dynamic> json)
  : user_id = json["user_id"],
    username = json["username"],
    password = json["password"],
    email = json["email"],
    rank = json["rank"],
    unit = json["unit"];
}