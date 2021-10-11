import 'package:app/constants/colors.dart';
import 'package:flutter/material.dart';

class myBottomNavigation extends StatelessWidget {
  const myBottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TabBar(
      tabs: <Widget>[
        Tab(
          icon: Icon(Icons.home),
        ),
        Tab(
          icon: Icon(Icons.calendar_today),
        ),
        Tab(
          icon: Icon(Icons.local_library),
        ),
        Tab(
          icon: Icon(Icons.forum)
        ),
        Tab(
          icon: Icon(Icons.account_circle),
        ),
      ],
      labelColor: Color(COLOR_PRIMARY),
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: Color(COLOR_PRIMARY), width: 2.0),
        insets: EdgeInsets.only(bottom: 44),
      ),
      unselectedLabelColor: Colors.grey,
    );
  }
}
