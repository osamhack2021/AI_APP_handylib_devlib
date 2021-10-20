import 'package:app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:app/components/login_page/text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final Function() onEditingComplete;
  final TextInputAction textInputAction;
  final TextEditingController? controller;
  final Function(String value)? onChanged;
  final bool? enabled;
  final String? value;

  RoundedInputField(
      {Key? key,
      required this.hintText,
      this.icon = Icons.person,
      required this.textInputAction,
      required this.onEditingComplete,
      this.controller,
      this.onChanged,
      this.enabled,
      this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        enabled: "소속 부대" != hintText,
        controller: controller,
        onEditingComplete: onEditingComplete,
        onChanged: onChanged,
        textInputAction: textInputAction,
        cursorColor: const Color(COLOR_PRIMARY2),
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: const Color(COLOR_PRIMARY),
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
