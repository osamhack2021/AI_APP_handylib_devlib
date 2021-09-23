import 'package:app/components/custom_text_form_field.dart';
import 'package:app/components/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mongo_dart/mongo_dart.dart' show Db, DbCollection;
import 'package:http/http.dart' as http;

import '../size.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

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
        TextButton(
          onPressed:() {},
          child: Text("Login"),
        ),
        SizedBox(height:medium_gap),
        TextButton(
          onPressed: (

          ){},
          child : Text("Register"),
        )
      ]),
    ));
  }
}
