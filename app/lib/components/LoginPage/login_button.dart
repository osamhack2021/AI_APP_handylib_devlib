import 'package:app/constants/colors.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: const Color(COLOR_PRIMARY),
        elevation: 5,
      ),
      onPressed: () {
        Navigator.pushNamed(context, "/home");
      },
      child: Text(
        "Login",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
