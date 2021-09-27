import 'package:app/components/homeScreen/home_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:app/navigation/routes.dart';
import 'package:app/hooks/useApi.dart';

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
    // fetchData();
  }

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
