import 'package:app/components/homeScreen/home_bottom_nav.dart';
import 'package:app/controller/user_controller.dart';
import 'package:flutter/material.dart';

import 'package:app/navigation/routes.dart';
import 'package:app/pages/login_page.dart';

User? myUser = User("홍길동", "eat333", "12345", "hi@gmail.com","군사안보지원사령부","상병");

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    //myUser = ModalRoute.of(context)!.settings.arguments as User?;
    return Scaffold(
      body: DefaultTabController(
          length: 4,
          child: Stack(children: [
            Container(
              height: double.infinity,
              width: double.infinity,
            ),
            Scaffold(
              bottomNavigationBar: myBottomNavigation(),
              body: TabBarView(children: homeRoute),
            )
          ])),
    );
  }
}
