import 'package:app/components/LoginPage/login_button.dart';
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
        SizedBox(height:xlarge_gap),
        Logo(
          "Login",
        ),
        CustomTextFormField(
          title:"ID",
          hintText: " Enter ID"
        ),
        SizedBox(height:small_gap),
        CustomTextFormField(
          title:"Password",
          hintText: "Enter Password"
        ),
        SizedBox(height:large_gap),
        LoginButton( ),
         TextButton(
          onPressed:() {
            Navigator.pushNamed(context,"/home");
          },
          child: Text("Register"),
        ),
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
      ]),
    ));
  }
}


