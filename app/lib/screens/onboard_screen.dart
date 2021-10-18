import 'package:app/components/error_notifier.dart';
import 'package:app/components/login_page/rounded_button.dart';
import 'package:app/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


User? myUser;

class OnboardScreen extends StatefulWidget {
  OnboardScreen({Key? key}) : super(key: key);

  @override
  _OnboardScreenState createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  String myUri = 'https://www.projectlib.tk/';
  void warp() {
    Navigator.of(context).pushNamedAndRemoveUntil(
      '/home',
      (route) => false,
      arguments: User(myUser!.username, myUser!.userId, myUser!.password,
          myUser!.email, myUser!.unit, myUser!.rank),
    );
  }

  void like(String isbn)async{
    
    await http.post(

    Uri.parse(myUri + 'like/?user_id=${myUser!.userId}&isbn=${isbn}/'),

    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  }

  @override
  Widget build(BuildContext context) {
    myUser = ModalRoute.of(context)!.settings.arguments as User?;
    if (myUser == null) {
      return const Scaffold(
        body: ErrorNotifier(
          errorMessage: '유저 정보를 불러오지 못했어요. 앱을 다시 실행해주세요.',
        ),
      );
    }

    return Scaffold(
        body: Column(children: [
      RoundedButton(
        text: "로그인",
        press: warp,
      ),
    ]));
  }
}
