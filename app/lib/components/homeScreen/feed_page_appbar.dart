import 'package:app/constants/colors.dart';
import 'package:flutter/material.dart';

AppBar FeedPageAppBar() {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0.0,
    title: Center(
      child: Image(
        image: AssetImage('assets/images/logo.png'),
        width: 100,
        height: 100,
      ),
    ),
    leading: IconButton(
      padding: EdgeInsets.only(left: 30.0),
      onPressed: () => print('Menu'),
      icon: Icon(Icons.menu),
      iconSize: 30.0,
      color: Colors.black,
    ),
    actions: <Widget>[
      IconButton(
        padding: EdgeInsets.only(right: 30.0),
        onPressed: () => print('Search'),
        icon: Icon(Icons.search),
        iconSize: 30.0,
        color: Color(COLOR_PRIMARY),
      ),
    ],
  );
}
