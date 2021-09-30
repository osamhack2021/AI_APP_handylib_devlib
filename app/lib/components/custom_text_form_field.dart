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
        //Text(title),
        TextFormField(
          controller: controller,
          initialValue: null,
          obscureText: ( title == "password") ? true : false,
          onSaved: (String? _value){},
          validator: (_value) {
            if(_value!.length<8 && title == "password") {
              return '비밀번호는 8자 이상이어야 합니다.';
            }
            else if(_value.isEmpty){
              return '필수 입력 항목입니다.';
            }
          },
          decoration: InputDecoration(
            hintText: hintText,
          ),
        ),
      ],
    );
  }
}
