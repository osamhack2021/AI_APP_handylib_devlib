import 'package:app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:app/components/login_page/text_field_container.dart';

class RoundedPasswordField extends StatefulWidget {
  final Function() onEditingComplete;
  final TextInputAction textInputAction;
  final TextEditingController? controller;

  RoundedPasswordField(
      {Key? key,
      required this.textInputAction,
      required this.onEditingComplete,
      this.controller})
      : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool _flag = true;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: widget.controller,
        onEditingComplete: widget.onEditingComplete,
        textInputAction: widget.textInputAction,
        obscureText: _flag,
        cursorColor: const Color(COLOR_PRIMARY),
        decoration: InputDecoration(
          hintText: "비밀번호",
          icon: const Icon(
            Icons.lock,
            color: Color(COLOR_PRIMARY),
          ),
          suffixIcon: InkWell(
            onTap: () => {
              setState(() {
                _flag = _flag ? false : true;
              })
            },
            child: const Icon(
              Icons.visibility,
              color: Color(COLOR_PRIMARY),
            ),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
