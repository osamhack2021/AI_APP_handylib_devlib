import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<User> createAccount(String username, String id, String password) async{
  final response = await http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/albums'),
    headers:<String, String>{
      'Content-Type' : 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'id':id,
    }),
  );

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Entry');
  }

}

Future<User> fetchUser() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return User.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
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