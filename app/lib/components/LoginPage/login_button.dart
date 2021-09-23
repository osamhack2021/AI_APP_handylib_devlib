import 'package:app/constants/colors.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style:TextButton.styleFrom(
        backgroundColor:Color(COLOR_PRIMARY),
      ),
      onPressed:() {
        Navigator.pushNamed(context,"/home");
      },
      child: Text("Login"),
    );
  }
}