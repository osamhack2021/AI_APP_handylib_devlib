import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Container(
          width: 100,
          height: 100,
          child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/auth/register");
              },
              icon: Icon(Icons.flutter_dash)),
        ),
        Container(
          width: 100,
          height: 100,
          child: IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/home");
              },
              icon: Icon(Icons.flutter_dash)),
        )
      ],
    ));
  }
}
