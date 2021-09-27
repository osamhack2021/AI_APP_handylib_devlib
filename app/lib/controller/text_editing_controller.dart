import 'package:flutter/material.dart';

class TextCustomForm extends StatefulWidget {

  @override
  _TextCustomFormState createState() => _TextCustomFormState();
}

class _TextCustomFormState extends State<TextCustomForm> {
  
  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}