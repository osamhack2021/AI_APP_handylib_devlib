import 'package:app/components/error_notifier.dart';
import 'package:app/components/homeScreen/home_bottom_nav.dart';
import 'package:app/constants/uri.dart';
import 'package:app/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:app/navigation/routes.dart';

User? myUser;

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    myUser = ModalRoute.of(context)!.settings.arguments as User?;
    
    //below code is for debug 
    //myUser = User('defaultName', 'defaultId', 'defaultPassword', 'defaultEmail', 'defaultUnit', 'defaultRank');
    
    if (myUser == null)
      return Scaffold(
        body: ErrorNotifier(
          errorMessage: '유저 정보를 불러오지 못했어요. 앱을 다시 실행해주세요.',
        ),
      );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: DefaultTabController(
          length: 5,
          child: Stack(children: [
            Container(
              height: double.infinity,
              width: double.infinity,
            ),
            Scaffold(
              resizeToAvoidBottomInset: false,
              bottomNavigationBar: myBottomNavigation(),
              body: TabBarView(children: homeRoute),
            )
          ])),
    );
  }
}
