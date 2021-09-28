import 'package:app/constants/colors.dart';
import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: const Color(COLOR_PRIMARY),
        elevation: 5,
      ),
      onPressed: () {
        Navigator.pushNamed(context, '/auth/register');
      },
      child: Text(
        "Register",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
