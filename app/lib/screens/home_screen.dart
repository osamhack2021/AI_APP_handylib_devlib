import 'package:app/components/homeScreen/home_bottom_nav.dart';
import 'package:flutter/material.dart';

import 'package:app/routes.dart';
import 'package:app/pages/login_page.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
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
