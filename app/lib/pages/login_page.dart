import 'package:app/components/LoginPage/login_button.dart';
import 'package:app/components/LoginPage/register_button.dart';
import 'package:app/components/custom_text_form_field.dart';
import 'package:app/components/logo.dart';
import 'package:app/constants/size.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(children: [
        SizedBox(height: xlarge_gap),
        Logo(
          "Login",
        ),
        CustomTextFormField(title: "ID", hintText: " Enter ID"),
        SizedBox(height: small_gap),
        CustomTextFormField(title: "Password", hintText: "Enter Password"),
        SizedBox(height: large_gap),
        LoginButton(),
        SizedBox(height: medium_gap),
        RegisterButton(),
      ]),
    ));
  }
}

