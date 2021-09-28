// ignore_for_file: prefer_const_constructors

import 'package:app/components/custom_text_form_field.dart';
import 'package:app/components/logo.dart';
import 'package:app/constants/colors.dart';
import 'package:app/constants/size.dart';
import 'package:app/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RegisterPage extends StatefulWidget {

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _idController = TextEditingController();

  var myId='testID';
  @override

  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _idController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(children: [
              SizedBox(height: xlarge_gap),
              Logo("Register"),
              
              CustomTextFormField(
                title: "성명", 
                hintText: "홍길동",
                controller: _usernameController,
              ),
              SizedBox(height: medium_gap),
              CustomTextFormField(
                title: "ID", 
                hintText: "Enter ID",
                controller: _idController,
              ),
              SizedBox(height: medium_gap),
              CustomTextFormField(
                  title: "Password", 
                  hintText: "Enter Password",
                  controller: _passwordController,
              ),
              SizedBox(height:large_gap),
              ElevatedButton(
                onPressed: () {
                  debugPrint(_idController.value.text);
                  createUser(
                    _usernameController.value.text,
                    _idController.value.text,
                    _passwordController.value.text,
                  );
                }, 
                child: Text('Register'),
                style : ButtonStyle(
                  backgroundColor : MaterialStateProperty.all<Color>(Color(COLOR_PRIMARY)),
                )
              ),

            ])));
  }
}
