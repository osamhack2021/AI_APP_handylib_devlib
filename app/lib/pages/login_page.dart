// ignore_for_file: prefer_const_constructors

import 'package:app/components/login_page/rounded_button.dart';
import 'package:app/components/login_page/rounded_input_field.dart';
import 'package:app/components/login_page/rounded_password_field.dart';
import 'package:app/components/underlined_text.dart';
import 'package:app/constants/colors.dart';
import 'package:app/controller/user_controller.dart';

import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void handleSubmit() async {
    int res = await loginUser(
      _idController.value.text,
      _passwordController.value.text,
    );
    if (true) {
      /*final snackbar = SnackBar(content:Text('로그인에 성공했습니다.'));
                ScaffoldMessenger.of(context).showSnackBar(snackbar);*/
      Navigator.of(context).pushReplacementNamed(
        '/home',
        arguments: User("name", "id", "pa", "e", "b",
            "d"), //loadUserInfo(_idController.value.text),
      );
    } else if (res == 401) {
      final snackbar = SnackBar(content: Text('아이디 또는 비밀번호를 확인하여 주십시오.'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } else {
      debugPrint("login server failed");
      final snackbar = SnackBar(content: Text('로그인 서버에 연결하지 못했습니다.'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
            color: Colors.white,
            width: double.infinity,
            height: size.height,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: size.height * 0.08),
                  UnderLinedText(
                      text: "내 손안의 진중문고",
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                      thickness: 7),
                  Image(
                    image: AssetImage('assets/images/login.jpg'),
                    height: size.height * 0.4,
                  ),
                  SizedBox(height: size.height * 0.03),
                  RoundedInputField(
                    hintText: "이메일",
                    controller: _idController,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => node.nextFocus(),
                  ),
                  RoundedPasswordField(
                    textInputAction: TextInputAction.done,
                    onEditingComplete: () => handleSubmit,
                    controller: _passwordController,
                  ),
                  RoundedButton(
                    text: "로그인",
                    press: handleSubmit,
                  ),
                  SizedBox(height: size.height * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "아직 회원이 아니신가요? ",
                        style: TextStyle(color: Color(COLOR_PRIMARY)),
                      ),
                      GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, '/auth/register'),
                        child: Text(
                          "회원가입",
                          style: TextStyle(
                            color: Color(COLOR_PRIMARY),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )));
  }
}
