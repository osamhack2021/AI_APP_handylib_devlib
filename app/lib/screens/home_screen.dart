import 'package:app/components/homeScreen/home_bottom_nav.dart';
import 'package:app/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:app/navigation/routes.dart';
import 'package:app/hooks/useApi.dart';

User? myUser = User("홍길동", "eat333", "12345", "hi@gmail.com","군사안보지원사령부","상병");

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var data;

  void fetchData() async {
    Map<String, dynamic> param = aladinParam("9788901252438");
    String host = "www.aladin.co.kr";
    String path = "ttb/api/ItemLookUp.aspx";
    data = await api_get(param, host, path);
    print(data);
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

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
