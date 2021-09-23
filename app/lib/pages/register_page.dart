import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return
      Container(
      width: 100,
      height: 100,
      child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.flutter_dash)),
    );
  }
}
