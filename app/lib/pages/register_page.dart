import 'package:app/components/logo.dart';
import 'package:app/size.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children:[
           SizedBox(height:large_gap),
           Logo("Register"),
          ]

          ),
      )
    );
  }
}