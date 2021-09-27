import 'dart:convert';
import 'package:app/components/RegisterPage/make_account_button.dart';
import 'package:app/components/custom_text_form_field.dart';
import 'package:app/components/logo.dart';
import 'package:app/constants/size.dart';
import 'package:app/object/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;


class RegisterPage extends StatelessWidget {

  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _id = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(children: const [
              SizedBox(height: xlarge_gap),
              Logo("Register"),
              CustomTextFormField(
                title: "성명", 
                hintText: "홍길동",
                controller: _username,
              ),
              SizedBox(height: medium_gap),
              CustomTextFormField(
                title: "ID", 
                hintText: "Enter ID",
                controller: _id,
              ),
              SizedBox(height: medium_gap),
              CustomTextFormField(
                  title: "Password", 
                  hintText: "Enter Password",
                  controller: _password,
              ),
              SizedBox(height:large_gap),
              MakeAccountButton(),

            ])));
  }
}
