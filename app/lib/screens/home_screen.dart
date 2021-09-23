import 'package:app/components/homeScreen/home_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:app/navigation/routes.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          bottomNavigationBar: myBottomNavigation(),
          body: TabBarView(children: homeRoute),
        ));
  }
}
