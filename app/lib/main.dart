import 'package:app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:app/navigation/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      routes: routes,
    );
  }
}
