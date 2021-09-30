// ignore_for_file: prefer_const_constructors

import 'package:app/components/custom_text_form_field.dart';
import 'package:app/components/logo.dart';
import 'package:app/constants/colors.dart';
import 'package:app/constants/size.dart';
import 'package:app/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:crypt/crypt.dart';

class RegisterPage extends StatefulWidget {

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _unitController = TextEditingController();
  final TextEditingController _rankController = TextEditingController();

  var myId='testID';
  
  final _formKey = GlobalKey<FormState>();
  @override

  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _idController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
          key: _formKey,
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(children: [
                SizedBox(height: xlarge_gap),
                Logo("Register"),
                
                CustomTextFormField(
        
                  title: "name", 
                  hintText: "성명",
                  controller: _usernameController,
                ),
                SizedBox(height: medium_gap),
                CustomTextFormField(
                  title: "ID", 
                  hintText: "아이디",
                  controller: _idController,
                ),
                SizedBox(height: medium_gap),
                CustomTextFormField(
                    title: "password", 
                    hintText: "비밀번호(8자 이상)",
                    controller: _passwordController,
                ),
                SizedBox(height:medium_gap),
                CustomTextFormField(
                    title: "email", 
                    hintText: "이메일 주소",
                    controller: _emailController,
                ),
                SizedBox(height:medium_gap),
                CustomTextFormField(
                    title: "unit", 
                    hintText: "소속 부대",
                    controller: _unitController,
                ),
                SizedBox(height:medium_gap),
                CustomTextFormField(
                    title: "rank", 
                    hintText: "계급",
                    controller: _rankController,
                ),
                SizedBox(height:large_gap),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      debugPrint(_idController.value.text);
                      createUser(
                        _usernameController.value.text,
                        _idController.value.text,
                        _passwordController.value.text,
                        _emailController.value.text,
                        _unitController.value.text,
                        _rankController.value.text,
                      );
                    }
                  }, 
                  child: Text('회원가입'),
                  style : ButtonStyle(
                    backgroundColor : MaterialStateProperty.all<Color>(Color(COLOR_PRIMARY)),
                  )
                ),
                SizedBox(height:xlarge_gap),
        
              ])),
        ));
  }
}
