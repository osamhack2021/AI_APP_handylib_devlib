import 'package:app/constants/colors.dart';
import 'package:flutter/material.dart';

class MakeAccountButton extends StatelessWidget {
  const MakeAccountButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: const Color(COLOR_PRIMARY),
        elevation: 5,
      ),
      onPressed: () {},
      child: const Text(
        "Make Account",
        style:TextStyle(
          color:Colors.white,
       ),
      ),
    );
  }
}
