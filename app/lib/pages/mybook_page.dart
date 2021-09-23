import 'package:flutter/material.dart';

class MyBookPage extends StatefulWidget {
  MyBookPage({Key? key}) : super(key: key);

  @override
  _MyBookPageState createState() => _MyBookPageState();
}

class _MyBookPageState extends State<MyBookPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("mybook page"),
    );
  }
}
