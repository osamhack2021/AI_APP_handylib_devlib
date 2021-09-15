
import 'package:app/pages/book_list_page.dart';
import 'package:app/pages/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "\login",
      routes: {
        "\login" :(context) => LoginPage(),
        //"\home" : (context) => HomePage()
      }
    );
  }
}