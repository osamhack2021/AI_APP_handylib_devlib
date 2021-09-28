import 'package:app/constants/size.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {

  final String title, hintText;
  final TextEditingController? controller;

  const CustomTextFormField({
    required this.title,
    required this.hintText, 
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        SizedBox(height:small_gap),
        TextFormField(
          controller: controller,
          initialValue: null,
          obscureText: ( title == "Password") ? true : false,
          decoration: InputDecoration(
            hintText: hintText,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
