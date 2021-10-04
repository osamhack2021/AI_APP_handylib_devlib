// ignore_for_file: prefer_const_constructors

import 'package:app/components/custom_text_form_field.dart';
import 'package:app/components/logo.dart';
import 'package:app/constants/colors.dart';
import 'package:app/constants/size.dart';
import 'package:app/controller/user_controller.dart';
import 'package:app/screens/home_screen.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(children: [
          SizedBox(height: xlarge_gap),
          Logo(
            "Login",
          ),
          CustomTextFormField(
            title: "ID", 
            hintText: "아이디",
            controller: _idController,
          ),
          SizedBox(height: small_gap),
          CustomTextFormField(
            title: "password", 
            hintText: "비밀번호",
            controller : _passwordController,
          ),
          SizedBox(height: large_gap),
          ElevatedButton(
            onPressed: () async {
               int res = await loginUser(
                 _idController.value.text,
                 _passwordController.value.text,
               );
               if(true) {
                /*final snackbar = SnackBar(content:Text('로그인에 성공했습니다.'));
                ScaffoldMessenger.of(context).showSnackBar(snackbar);*/
                Navigator.of(context).pushReplacementNamed(
                   
                   '/home',
                   arguments: User("name","id","pa","e","b","d"), //loadUserInfo(_idController.value.text),
                 );
               }
              else if(res == 401){
                 final snackbar = SnackBar(content:Text('아이디 또는 비밀번호를 확인하여 주십시오.'));
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
               }
              else {
                debugPrint("login server failed");
                final snackbar = SnackBar(content:Text('로그인 서버에 연결하지 못했습니다.'));
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
              }
            }, 
            child: Text(
              '로그인',
            ),
            style:ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(COLOR_PRIMARY)),
            )
          ),
          SizedBox(height: medium_gap),
          Center(
            child: InkWell(
              child:Text("아직 회원이 아니신가요?"),
              onTap:() => Navigator.pushNamed(context,'/auth/register'),
            ),
          )
          ]
        ),
      ),
    );
  }
}
