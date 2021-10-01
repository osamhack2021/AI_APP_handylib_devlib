import 'package:app/pages/contest_page.dart';
import 'package:app/pages/forum_page.dart';
import 'package:flutter/material.dart';

class ForumScreen extends StatefulWidget {
  const ForumScreen({Key? key}) : super(key: key);

  @override
  _ForumScreenState createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:DefaultTabController(
        length:2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(text:'contest'),
                Tab(text:'forum'),
              ],
            ),
            title: (
              Center(
                child: Text('Tab'),
              )
            ),
          ),
          body:const TabBarView(children: [
            ContestPage(),
            ForumPage(),
          ],)
          ),)
    );
  }
}
