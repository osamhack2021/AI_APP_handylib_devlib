import 'package:app/components/custom_text_form_field.dart';
import 'package:app/components/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(children: [
        Logo(
          "Login",
        ),
        CustomTextFormField(),
      ]),
    ));
  }
}
